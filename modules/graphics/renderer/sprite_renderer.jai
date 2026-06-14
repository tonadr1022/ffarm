CameraUniform :: struct {
    cam_pos: Vector2;
    world_to_clip: Vector2;
}

SpriteInstance :: struct {
    pos: Vector2;
    size: Vector2;
    uv_min: Vector2;
    uv_max: Vector2;
    color: Vector4;
    depth: float;
    _padding: [3]float;
}

SpriteDrawCommand :: struct {
    texture_view: TextureViewHandle;
    instance: SpriteInstance;
}

SpriteRenderer :: struct {
    device: *RHI.Device;
    draw_commands: [..]SpriteDrawCommand;
    instance_buffers: [MAX_FRAMES_IN_FLIGHT]BufferHandle;
    instance_buffer_capacities: [MAX_FRAMES_IN_FLIGHT]u32;
    camera: CameraUniform;
    fga: FrameGpuAllocator2(.Uniform);
}

#assert size_of(SpriteInstance) == 64;

sprite_renderer_init :: (device: *RHI.Device) {
    sprite_renderer.device = device;
}

sprite_renderer_shutdown :: () {
    frame_gpu_allocator2_destroy(*sprite_renderer.fga);
    for i : 0..MAX_FRAMES_IN_FLIGHT-1 {
        if sprite_renderer.instance_buffer_capacities[i] > 0 {
            buffer_destroy(sprite_renderer.instance_buffers[i]);
            sprite_renderer.instance_buffer_capacities[i] = 0;
        }
    }
}

sprite_renderer_begin_frame :: (cam_pos: Vector2, world_to_clip: Vector2) {
    sprite_renderer.camera.cam_pos = cam_pos;
    sprite_renderer.camera.world_to_clip = world_to_clip;
    sprite_renderer.draw_commands.count = 0;
    frame_gpu_allocator2_reset_frame(*sprite_renderer.fga, renderer_get_curr_frame_in_flight_idx());
}

sprite_renderer_draw :: (texture_view: TextureViewHandle, instance: SpriteInstance) {
    cmd := array_add(*sprite_renderer.draw_commands);
    cmd.texture_view = texture_view;
    cmd.instance = instance;
}

sprite_renderer_upload_sprite :: (sprite: SpriteAssetHandle) -> success: bool {
    sprite_asset: *SpriteAsset = get(sprite);
    assert(sprite_asset != null);
    w, h, channels: s32;
    data := stbi_load(temp_c_string(sprite_asset.path), *w, *h, *channels, 4);
    if !data {
        print("Failed to load sprite image: %\n", to_string(stbi_failure_reason()));
        return false;
    }
    defer stbi_image_free(data);
    sprite_asset.texture = texture_create(*(RHI.TextureDesc.{
        size=.{xx w, xx h, 1},
        dimension=.D2,
        format=RHI.TextureFormat.R8G8B8A8_UNORM,
        usage=RHI.TextureUsageFlags.SAMPLED,
    }));

    sprite_asset.texture_view = texture_view_create(*(RHI.TextureViewDesc.{
        texture=get(sprite_asset.texture),
    }));

    copy_data_to_texture(sprite_asset.texture, data, xx (w * h * 4));
    return true;
}

#scope_module

sprite_renderer_render_pass_draw :: (cmd: *RHI.CommandBuffer) {
    if sprite_renderer.draw_commands.count == 0 return;

    frame_idx := renderer_get_curr_frame_in_flight_idx();
    cam_buf := frame_gpu_allocator2_alloc(*sprite_renderer.fga, *sprite_renderer.camera);

    quick_sort(sprite_renderer.draw_commands, (a: SpriteDrawCommand, b: SpriteDrawCommand) -> s64 {
        if a.instance.depth < b.instance.depth return -1;
        if a.instance.depth > b.instance.depth return 1;
        return cast(s64)a.texture_view.index - cast(s64)b.texture_view.index;
    });

    RHI.bind_cbv(cmd, get(cam_buf.buf), slot=0, offset_bytes=cam_buf.offset, size_bytes=size_of(CameraUniform));

    total_count := cast(u32) sprite_renderer.draw_commands.count;
    ensure_instance_buffer_capacity(frame_idx, total_count);

    instance_buf := get(sprite_renderer.instance_buffers[frame_idx]);
    dest := cast(*SpriteInstance) instance_buf.data;
    for i: 0..total_count-1 {
        dest[i] = sprite_renderer.draw_commands[i].instance;
    }

    batch_start := 0;
    while batch_start < sprite_renderer.draw_commands.count {
        batch_texture := sprite_renderer.draw_commands[batch_start].texture_view;
        batch_end := batch_start + 1;
        while batch_end < sprite_renderer.draw_commands.count {
            next := sprite_renderer.draw_commands[batch_end].texture_view;
            if next.index != batch_texture.index || next.generation != batch_texture.generation break;
            batch_end += 1;
        }

        batch_count := cast(u32)(batch_end - batch_start);

        RHI.bind_srv_texture_view(cmd, get(batch_texture), slot=1);
        RHI.bind_srv(cmd, instance_buf, slot=2, offset_bytes=cast(u32)(batch_start * size_of(SpriteInstance)));
        RHI.draw(cmd, sprite_renderer.device, renderer_get_bind_pool(), vertex_count=6, instance_count=batch_count);

        batch_start = batch_end;
    }
}

#scope_file

sprite_renderer: SpriteRenderer;

ensure_instance_buffer_capacity :: (frame_idx: u32, instance_count: u32) {
    needed_bytes := instance_count * size_of(SpriteInstance);
    if needed_bytes <= sprite_renderer.instance_buffer_capacities[frame_idx] return;

    if sprite_renderer.instance_buffer_capacities[frame_idx] > 0 {
        buffer_destroy(sprite_renderer.instance_buffers[frame_idx]);
    }

    prev_capacity := sprite_renderer.instance_buffer_capacities[frame_idx];
    new_capacity := max(needed_bytes, max(prev_capacity * 2, 64 * size_of(SpriteInstance)));
    sprite_renderer.instance_buffers[frame_idx] = buffer_create(*(RHI.BufferDesc.{
        size=new_capacity,
        flags=.HostVisible,
        usage=.Storage,
    }));
    sprite_renderer.instance_buffer_capacities[frame_idx] = new_capacity;
}

RHI :: #import "graphics/rhi";
#import "Basic";
#import "Math";
#import "graphics/sprites";
#import "runtime/assets";
#import "stb_image";
#import "File_Utilities";
#import "Sort";
