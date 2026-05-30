Renderer :: struct {
    device: RHI.Device;
    window: *Window;
    swapchain: RHI.Swapchain;

    frames: [MAX_FRAMES_IN_FLIGHT]FrameRenderData;
    frames_in_flight: u32;
    curr_frame_in_flight_idx: u32;
    curr_frame_number: u64;

    tri_buffer: BufferHandle;
    tint_buffer: BufferHandle;
    test_tex: TextureHandle;
    test_img_view: TextureViewHandle;
    basic_tri_pipeline: *RHI.Pipeline;
    staging_buf_allocator: FrameGpuAllocator;
}

FrameRenderData :: struct {
    cmd_pool: RHI.CommandPool;
    cmd_buf: RHI.CommandBuffer;
    bind_pool: RHI.BindPool;
    sync: FrameSync;
}

BufferAndOffset :: struct {
    buf: BufferHandle;
    offset: u32;
}

FrameGpuAllocator :: struct {
    PerFrame :: struct {
        bufs: [..]BufferAndOffset;
        free_bufs: [..]BufferAndOffset;
    }
    curr_frame: u32;
    frames: [MAX_FRAMES_IN_FLIGHT]PerFrame;
}

frame_gpu_allocator_reset_frame :: (fga: *FrameGpuAllocator, frame_idx: u32) {
    frame_data := fga.frames[frame_idx];
    array_reserve(*frame_data.free_bufs, frame_data.free_bufs.count + frame_data.bufs.count);
    for * buf : frame_data.bufs {
        array_add(*frame_data.free_bufs, buf);
    }
    array_reset_keeping_memory(*frame_data.bufs);

    for * buf : frame_data.free_bufs {
        buf.offset = 0;
    }
    fga.curr_frame = frame_idx;
}

frame_gpu_allocator_alloc :: (fga: *FrameGpuAllocator, data: *$T, size: u32) -> BufferAndOffset {
    frame_data : *FrameGpuAllocator.PerFrame = *fga.frames[fga.curr_frame];
    alloc_to_buf :: (buf_and_offset: *BufferAndOffset, data: *$T, size: u32) -> BufferAndOffset {
        buf_act := get(buf_and_offset.buf);
        assert(buf_act.data != null);
        memcpy(buf_act.data, data, size);
        result : BufferAndOffset = buf_and_offset.*;
        buf_and_offset.offset += size;
        return result;
    }
    for * buf : frame_data.free_bufs {
        buf_act := get(buf.buf);
        if buf.offset + size <= buf_act.desc.size {
            return alloc_to_buf(buf, data, size);
        }
    }

    desc := RHI.BufferDesc.{
        size = size,
        flags = RHI.BufferCreateFlags.HostVisible,
        usage = RHI.BufferUsageFlags.TransferSrc,
    };
    new_buf := BufferAndOffset.{buffer_create(*desc), 0};
    array_add(*frame_data.free_bufs, new_buf);
    return alloc_to_buf(*frame_data.free_bufs[frame_data.free_bufs.count-1], data, size);
}

frame_gpu_allocator_destroy :: (fga: *FrameGpuAllocator) {
    for * frame : fga.frames {
        for * buf_and_offset : frame.free_bufs {
            buffer_destroy(buf_and_offset.buf);
        }
        for * buf_and_offset : frame.bufs {
            buffer_destroy(buf_and_offset.buf);
        }
    }
}

Vertex :: struct {
    position: Vector3;
    uv: Vector2;
    color: Vector3;
}

FrameSync :: struct {
    acquire_sem: RHI.Semaphore;
    render_complete_sem: RHI.Semaphore;
    in_flight_fence: RHI.Fence;
}

renderer: Renderer;

init :: (window: *Window) {
    using,except (window) renderer;
    renderer.window = window;
    curr_frame_in_flight_idx = 0;
    curr_frame_number = 0;

    frames_in_flight = 3;
    settings: RHI.DeviceSettings = .{
        exit_on_validation_layer_error=true,
        validation_layers_enabled=true,
        frames_in_flight = frames_in_flight
    };
    RHI.device_init(*device, *settings);
    assert(window.sdl_window != null);
    window.surface = RHI.create_surface(*device, window.sdl_window);
    win_size_w, win_size_h := window_get_size(window);
    vsync :: true;
    RHI.swapchain_init(*swapchain, *device, window.surface, win_size_w, win_size_h, vsync);
    for i : 0..frames_in_flight-1 {
        frame := *frames[i];
        RHI.command_pool_init(*frame.cmd_pool, *device, RHI.QueueFamily.GRAPHICS);
        frame.cmd_buf = RHI.command_pool_alloc_buf(*frame.cmd_pool, *device);
        RHI.bind_pool_init(*frame.bind_pool, *device);
        RHI.semaphore_create(*frame.sync.acquire_sem, *device);
        RHI.semaphore_create(*frame.sync.render_complete_sem, *device);
        RHI.fence_create(*frame.sync.in_flight_fence, *device, signaled=true);
    }

    vertices := Vertex.[
        .{.{-0.5, -0.5, 0.0}, .{0.0, 1.0}, .{1.0, 0.0, 0.0}},
        .{.{ 0.5, -0.5, 0.0}, .{1.0, 1.0}, .{0.0, 1.0, 0.0}},
        .{.{ 0.0,  0.5, 0.0}, .{0.5, 0.0}, .{0.0, 0.0, 1.0}},
    ];

    gpu_resources_init(*device);
    vertices_size_bytes : u32 = vertices.count * size_of(Vertex);
    tri_buffer = buffer_create(*(RHI.BufferDesc.{
        size=vertices_size_bytes,
        usage=.Storage | .TransferDst,
    }));
    tint_buffer = buffer_create(*(RHI.BufferDesc.{
        size=16,
        flags=.HostVisible,
        usage=.Uniform | .TransferDst,
    }));
    test_tex = texture_create(*(RHI.TextureDesc.{
        size=.{1,1,1},
        dimension=.D2,
        format=RHI.TextureFormat.R32G32B32A32_SFLOAT,
        usage=RHI.TextureUsageFlags.SAMPLED,
    }));
    test_img_view = texture_view_create(*(RHI.TextureViewDesc.{
        texture=get(test_tex),
    }));

    tint := Vector4.{1.0, 1.0, 1.0, 1.0};
    memcpy(get(tint_buffer).data, *tint, size_of(Vector4));

    buf_and_offset := frame_gpu_allocator_alloc(*staging_buf_allocator, vertices.data, vertices_size_bytes);
    {
        submit := immediate_submit_begin();
        RHI.copy_buffer_to_buffer(*submit.cmd_buf, get(buf_and_offset.buf), get(tri_buffer), vertices_size_bytes);
        immediate_submit_end(*submit);
    }

    texels := Vector4.[.{1.0, 1.0, 1.0, 1.0}];
    tex_staging := frame_gpu_allocator_alloc(*staging_buf_allocator, texels.data, texels.count * size_of(Vector4));
    {
        submit := immediate_submit_begin();
        to_copy_dst := RHI.TextureBarrierDesc.{
            texture=get(test_tex),
            before=.UNDEFINED,
            after=.COPY_DST,
        };
        RHI.texture_barrier(*submit.cmd_buf, *to_copy_dst);
        RHI.copy_buffer_to_texture(*submit.cmd_buf, get(tex_staging.buf), get(test_tex), texels.count * size_of(Vector4));
        to_shader_read := RHI.TextureBarrierDesc.{
            texture=get(test_tex),
            before=.COPY_DST,
            after=.SHADER_READ,
        };
        RHI.texture_barrier(*submit.cmd_buf, *to_shader_read);
        immediate_submit_end(*submit);
    }

    vert_spirv := load_binary_file("resources/shader_out/spirv/basic_tri.vert.spirv");
    defer free(vert_spirv.data);
    frag_spirv := load_binary_file("resources/shader_out/spirv/basic_tri.frag.spirv");
    defer free(frag_spirv.data);
    pipe_desc := RHI.GraphicsPipelineDesc.{
        vertex_spirv = vert_spirv,
        fragment_spirv = frag_spirv,
        color_format = swapchain.format,
    };
    basic_tri_pipeline = RHI.pipeline_create(*device, *pipe_desc);
}

ImmediateSubmitData :: struct {
    cmd_pool: RHI.CommandPool;
    cmd_buf: RHI.CommandBuffer;
    fence: RHI.Fence;
}

immediate_submit_begin :: () -> ImmediateSubmitData {
    immediate_sub_data: ImmediateSubmitData;
    RHI.command_pool_init(*immediate_sub_data.cmd_pool, *renderer.device, RHI.QueueFamily.GRAPHICS);
    RHI.command_pool_reset(*immediate_sub_data.cmd_pool, *renderer.device);
    RHI.fence_create(*immediate_sub_data.fence, *renderer.device, signaled=true);
    RHI.fence_reset(*renderer.device, *immediate_sub_data.fence);
    immediate_sub_data.cmd_buf = RHI.command_pool_alloc_buf(*immediate_sub_data.cmd_pool, *renderer.device);
    RHI.cmd_begin(*immediate_sub_data.cmd_buf, *renderer.device);
    return immediate_sub_data;
}

immediate_submit_end :: (cmd: *ImmediateSubmitData) {
    RHI.cmd_end(*cmd.cmd_buf);
    submit_desc := RHI.QueueSubmitDesc.{
        cmd_buffers=.[*cmd.cmd_buf],
        fence=*cmd.fence,
    };
    RHI.queue_submit(*renderer.device, *submit_desc);
    RHI.fence_wait(*renderer.device, *cmd.fence, U64_MAX);
    RHI.fence_reset(*renderer.device, *cmd.fence);
    RHI.fence_destroy(*cmd.fence, *renderer.device);
    RHI.command_pool_destroy(*cmd.cmd_pool, *renderer.device);
}

shutdown :: () {
    using renderer;
    RHI.device_wait_idle(*device);

    if basic_tri_pipeline RHI.pipeline_destroy(*device, basic_tri_pipeline);
    frame_gpu_allocator_destroy(*staging_buf_allocator);
    buffer_destroy(tri_buffer);
    buffer_destroy(tint_buffer);
    texture_view_destroy(test_img_view);
    texture_destroy(test_tex);
    for i : 0..frames_in_flight-1 {
        frame := *frames[i];
        RHI.bind_pool_destroy(*frame.bind_pool, *device);
        RHI.semaphore_destroy(*frame.sync.acquire_sem, *device);
        RHI.semaphore_destroy(*frame.sync.render_complete_sem, *device);
        RHI.fence_destroy(*frame.sync.in_flight_fence, *device);
        RHI.command_pool_destroy(*frame.cmd_pool, *device);
    }
    RHI.swapchain_destroy(*swapchain);
    RHI.destroy_surface(*device, window.surface);
    RHI.device_free(*device);
    curr_frame_number = 0;
    curr_frame_in_flight_idx = 0;
}

do_render :: () {
    using renderer;
    frame_data := *frames[curr_frame_in_flight_idx];
    sync := *frame_data.sync;

    RHI.fence_wait(*device, *sync.in_flight_fence, U64_MAX);
    RHI.fence_reset(*device, *sync.in_flight_fence);
    RHI.command_pool_reset(*frame_data.cmd_pool, *device);
    RHI.bind_pool_reset(*frame_data.bind_pool, *device);

    frame_gpu_allocator_reset_frame(*staging_buf_allocator, curr_frame_in_flight_idx);
    swap_frame := RHI.swapchain_acquire(*swapchain, *device, *sync.acquire_sem);

    cmd_buf := *frame_data.cmd_buf;
    RHI.cmd_begin(cmd_buf, *device);
    cmd_buf.descriptors_dirty = false;
    cmd_buf.bound_pipeline = null;

    acquire_wait_stage := RHI.PipelineStage.COLOR_ATTACHMENT_OUTPUT;

    before_state := swap_frame.texture.current_state;
    if before_state != .COLOR_RENDER_TARGET {
        barrier_desc := RHI.TextureBarrierDesc.{
            texture=swap_frame.texture,
            before=before_state,
            after=.COLOR_RENDER_TARGET,
            src_stage=acquire_wait_stage,
        };
        RHI.texture_barrier(cmd_buf, *barrier_desc);
    }

    pass_desc := RHI.RenderPassDesc.{
        color_attachment_count=1,
        color_attachments[0]=.{
            view=swap_frame.view,
            load_op=.CLEAR,
            store_op=.STORE,
            clear_color=.{0.2, 0.4, 0.8, 1.0},
        },
        render_area=.{offset=.{0,0}, extent=swapchain.extent},
    };
    RHI.begin_render_pass(cmd_buf, *pass_desc);
    RHI.set_viewport_scissor(cmd_buf, swapchain.extent);
    RHI.bind_pipeline(cmd_buf, basic_tri_pipeline);
    RHI.bind_srv(cmd_buf, get(tri_buffer), slot=0);
    RHI.bind_srv_texture_view(cmd_buf, get(test_img_view), slot=1);
    RHI.bind_cbv(cmd_buf, get(tint_buffer), slot=0, offset_bytes=0, size_bytes=16);
    RHI.draw(cmd_buf, *device, *frame_data.bind_pool, vertex_count=3, instance_count=1);
    RHI.end_render_pass(cmd_buf);

    present_barrier := RHI.TextureBarrierDesc.{
        texture=swap_frame.texture,
        before=.COLOR_RENDER_TARGET,
        after=.PRESENT,
    };
    RHI.texture_barrier(cmd_buf, *present_barrier);

    RHI.cmd_end(cmd_buf);

    submit_desc := RHI.QueueSubmitDesc.{
        cmd_buffers=.[cmd_buf],
        waits=.[.{semaphore=*sync.acquire_sem, stage=acquire_wait_stage}],
        signal_semaphores=.[*sync.render_complete_sem],
        fence=*sync.in_flight_fence,
    };
    RHI.queue_submit(*device, *submit_desc);
    RHI.swapchain_present(*swapchain, *device, swap_frame.image_index, *sync.render_complete_sem);

    curr_frame_in_flight_idx = (curr_frame_in_flight_idx + 1) % frames_in_flight;
    curr_frame_number += 1;
}

#scope_file

MAX_FRAMES_IN_FLIGHT :: 3;

load_binary_file :: (path: string) -> []u8 {
    content, success := read_entire_file(path, false, false);
    if !success {
        print("Failed to read file: %\n", path);
        exit(1);
    }
    result: []u8;
    result.count = content.count;
    result.data = alloc(content.count);
    memcpy(result.data, content.data, content.count);
    return result;
}

RHI :: #import "graphics/rhi";
#import "platform";
#import "Basic";
#import "Math";
#import "File";
