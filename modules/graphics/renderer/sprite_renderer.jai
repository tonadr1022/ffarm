SpriteRenderer :: struct {
    device: *RHI.Device;
    sprites_to_draw: [..]*Sprite;
    vertex_buffer: BufferHandle;
}

sprite_renderer_init :: (device: *RHI.Device) {
    using,except(device) sprite_renderer;
    sprite_renderer.device = device;

    vertex_buffer = buffer_create(*(RHI.BufferDesc.{
        size=size_of(Vertex) * 6,
        usage=.TransferDst | .Storage,
    }));

    vertices := Vertex.[
        .{.{-1.0, -1.0, 0.0}, .{0.0, 1.0}, .{1,1,1}},
        .{.{ 1.0, -1.0, 0.0}, .{0.02439, 1.0}, .{1,1,1}},
        .{.{-1.0,  1.0, 0.0}, .{0.0, 0.0}, .{1,1,1}},
        .{.{ 1.0,  1.0, 0.0}, .{0.02439, 0.0}, .{1,1,1}},
        .{.{-1.0,  1.0, 0.0}, .{0.0, 0.0}, .{1,1,1}},
        .{.{ 1.0, -1.0, 0.0}, .{0.02439, 1.0}, .{1,1,1}},
    ];

    vertices_size_bytes : u32 = vertices.count * size_of(Vertex);

    buf_and_offset := frame_gpu_allocator_alloc(*renderer.staging_buf_allocator, vertices.data, vertices_size_bytes);
    {
        submit := immediate_submit_begin();
        RHI.copy_buffer_to_buffer(*submit.cmd_buf, get(buf_and_offset.buf), get(vertex_buffer), vertices_size_bytes);
        immediate_submit_end(*submit);
    }
}

sprite_renderer_draw_sprite :: (sprite: *Sprite) {
    array_add(*sprite_renderer.sprites_to_draw, sprite);
}

sprite_renderer_shutdown :: () {
    buffer_destroy(sprite_renderer.vertex_buffer);
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

    copy_data_to_texture(sprite_asset.texture, data, xx (w * h * channels));
    return true;
}

#scope_module

sprite_renderer_render_pass_draw :: (cmd: *RHI.CommandBuffer) {
    // PushConstants :: struct {
    //     matrix: Matrix4 = Matrix4_Identity;
    // }
    // push_constants: PushConstants;
    // RHI.push_constants(cmd, size_of(PushConstants), *push_constants, 0);

    assert(sprite_renderer.sprites_to_draw.count > 0);
    sprite := sprite_renderer.sprites_to_draw[0];
    RHI.bind_srv_texture_view(cmd, get(sprite.texture_view), slot=1);
    RHI.bind_srv(cmd, get(sprite_renderer.vertex_buffer), slot=0);
    for sprite: sprite_renderer.sprites_to_draw {
        RHI.draw(cmd, sprite_renderer.device, renderer_get_bind_pool(), 6, 1);
    }
    sprite_renderer.sprites_to_draw.count = 0;
}

#scope_file

sprite_renderer: SpriteRenderer;
RHI :: #import "graphics/rhi";
#import "Basic";
#import "graphics/sprites";
#import "runtime/assets";
#import "stb_image";
#import "File_Utilities";