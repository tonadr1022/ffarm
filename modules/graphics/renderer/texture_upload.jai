


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

#scope_file

RHI :: #import "graphics/rhi";