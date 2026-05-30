Renderer :: struct {
    device: RHI.Device;
    window: *Window;
    swapchain: RHI.Swapchain;

    gfx_cmd_pools: [MAX_FRAMES_IN_FLIGHT]RHI.CommandPool;
    frame_sync: [MAX_FRAMES_IN_FLIGHT]FrameSync;
    frames_in_flight: u32;
    curr_frame_in_flight_idx: u32;
    curr_frame_number: u64;

    tri_buffer: RHI.Buffer;
    test_buf: BufferHandle;
    test_tex: TextureHandle;
    test_img_view: TextureViewHandle;
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
    for 0..frames_in_flight-1 {
        RHI.command_pool_init(*gfx_cmd_pools[it], *device, RHI.QueueFamily.GRAPHICS);
        RHI.semaphore_create(*frame_sync[it].acquire_sem, *device);
        RHI.semaphore_create(*frame_sync[it].render_complete_sem, *device);
        RHI.fence_create(*frame_sync[it].in_flight_fence, *device, signaled=true);
    }

    gpu_resources_init(*device);
    RHI.buffer_init(*tri_buffer, *(RHI.BufferDesc.{size=24}), *device);
    test_buf = buffer_create(*(RHI.BufferDesc.{size=24}));
    test_tex = texture_create(*(RHI.TextureDesc.{
        size=.{2,2,1},
        format=RHI.TextureFormat.R32_SFLOAT,
        usage=RHI.TextureUsageFlags.COLOR_ATT
    }));
    test_img_view = texture_view_create(*(RHI.TextureViewDesc.{
        texture=get(test_tex),
    }));
}

shutdown :: () {
    using renderer;
    RHI.device_wait_idle(*device);

    RHI.buffer_destroy(*tri_buffer, *device);
    buffer_destroy(test_buf);
    texture_view_destroy(test_img_view);
    texture_destroy(test_tex);
    for 0..frames_in_flight-1 {
        RHI.semaphore_destroy(*frame_sync[it].acquire_sem, *device);
        RHI.semaphore_destroy(*frame_sync[it].render_complete_sem, *device);
        RHI.fence_destroy(*frame_sync[it].in_flight_fence, *device);
        RHI.command_pool_destroy(*gfx_cmd_pools[it], *device);
    }
    RHI.swapchain_destroy(*swapchain);
    RHI.destroy_surface(*device, window.surface);
    RHI.device_free(*device);
    curr_frame_number = 0;
    curr_frame_in_flight_idx = 0;
}

do_render :: () {
    using renderer;
    sync := *frame_sync[curr_frame_in_flight_idx];

    RHI.fence_wait(*device, *sync.in_flight_fence, U64_MAX);
    RHI.fence_reset(*device, *sync.in_flight_fence);
    RHI.command_pool_reset(*gfx_cmd_pools[curr_frame_in_flight_idx], *device);

    frame := RHI.swapchain_acquire(*swapchain, *device, *sync.acquire_sem);

    cmd_buf := RHI.command_pool_alloc_buf(*gfx_cmd_pools[curr_frame_in_flight_idx], *device);
    RHI.cmd_begin(*cmd_buf, *device);

    acquire_wait_stage := RHI.PipelineStage.COLOR_ATTACHMENT_OUTPUT;

    before_state := frame.texture.current_state;
    if before_state != .COLOR_RENDER_TARGET {
        barrier_desc := RHI.TextureBarrierDesc.{
            texture=frame.texture,
            before=before_state,
            after=.COLOR_RENDER_TARGET,
            src_stage=acquire_wait_stage,
        };
        RHI.texture_barrier(*cmd_buf, *barrier_desc);
    }

    pass_desc := RHI.RenderPassDesc.{
        color_attachment_count=1,
        color_attachments[0]=.{
            view=frame.view,
            load_op=.CLEAR,
            store_op=.STORE,
            clear_color=.{0.2, 0.4, 0.8, 1.0},
        },
        render_area=.{offset=.{0,0}, extent=swapchain.extent},
    };
    RHI.begin_render_pass(*cmd_buf, *pass_desc);
    RHI.end_render_pass(*cmd_buf);

/*
    pass_desc.color_attachments[0].clear_color.y = 1.0;
    pass_desc.render_area.extent.width /= 2;
    pass_desc.render_area.extent.height /= 2;
    RHI.begin_render_pass(*cmd_buf, *pass_desc);
    RHI.end_render_pass(*cmd_buf);
    */

    present_barrier := RHI.TextureBarrierDesc.{
        texture=frame.texture,
        before=.COLOR_RENDER_TARGET,
        after=.PRESENT,
    };
    RHI.texture_barrier(*cmd_buf, *present_barrier);

    RHI.cmd_end(*cmd_buf);

    cmd_bufs := *cmd_buf;
    submit_desc := RHI.QueueSubmitDesc.{
        cmd_buffers=.[cmd_bufs],
        waits=.[.{semaphore=*sync.acquire_sem, stage=acquire_wait_stage}],
        signal_semaphores=.[*sync.render_complete_sem],
        fence=*sync.in_flight_fence,
    };
    RHI.queue_submit(*device, *submit_desc);
    RHI.swapchain_present(*swapchain, *device, frame.image_index, *sync.render_complete_sem);

    curr_frame_in_flight_idx = (curr_frame_in_flight_idx + 1) % frames_in_flight;
    curr_frame_number += 1;
}

#scope_file

MAX_FRAMES_IN_FLIGHT :: 3;

RHI :: #import "graphics/rhi";
#import "platform";
#import "Basic";
#import "Math";
