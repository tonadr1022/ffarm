


// TODO: this doesn't support astc/bc7, etc.
copy_data_to_texture :: (texture: TextureHandle, data: *void, size: u32) {
    tex := get(texture);
    assert(tex != null);

    // TODO: don't copy if we don't need to. (unified mem on apple silicon)
    tex_staging := frame_gpu_allocator_alloc(*renderer.staging_buf_allocator, data, size);
    {
        submit := immediate_submit_begin();
        to_copy_dst := RHI.TextureBarrierDesc.{
            texture=tex,
            before=.UNDEFINED,
            after=.COPY_DST,
        };
        RHI.texture_barrier(*submit.cmd_buf, *to_copy_dst);
        RHI.copy_buffer_to_texture(*submit.cmd_buf, get(tex_staging.buf), tex, size);
        to_shader_read := RHI.TextureBarrierDesc.{
            texture=tex,
            before=.COPY_DST,
            after=.SHADER_READ,
        };
        RHI.texture_barrier(*submit.cmd_buf, *to_shader_read);
        immediate_submit_end(*submit);
    }
}

load_img_from_cpu :: (path: string) -> TextureHandle, TextureViewHandle, bool {
    w, h, channels: s32;
    data := stbi_load(temp_c_string(path), *w, *h, *channels, 4);
    tex: TextureHandle;
    view: TextureViewHandle;
    if !data {
        print("Failed to load sprite image at path %: %\n", path, to_string(stbi_failure_reason()));
        return tex, view, false;
    }

    defer stbi_image_free(data);

    tex = texture_create(*(RHI.TextureDesc.{
        size=.{xx w, xx h, 1},
        dimension=.D2,
        format=RHI.TextureFormat.R8G8B8A8_UNORM,
        usage=RHI.TextureUsageFlags.SAMPLED,
    }));

    view = texture_view_create(*(RHI.TextureViewDesc.{
        texture=get(tex),
    }));

    return tex, view, true;
}

#scope_file

RHI :: #import "graphics/rhi";
#import "stb_image";
