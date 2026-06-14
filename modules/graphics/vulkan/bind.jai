bind_cbv :: (cmd_buf: *CommandBuffer, buffer: *Buffer, slot: u32, offset_bytes: u32, size_bytes: u32) {
    assert(slot < TOTAL_CBV_BINDINGS);
    cmd_buf.binding_table.CBV[slot] = buffer;
    cmd_buf.binding_table.CBV_offsets[slot] = xx offset_bytes;
    cmd_buf.binding_table.CBV_sizes[slot] = xx size_bytes;
    cmd_buf.descriptors_dirty = true;
}

bind_srv :: (cmd_buf: *CommandBuffer, buffer: *Buffer, slot: u32, offset_bytes: u32 = 0) {
    assert(slot < TOTAL_SRV_BINDINGS);
    cmd_buf.binding_table.SRV_buffers[slot] = buffer;
    cmd_buf.binding_table.SRV_subresources[slot] = DescriptorBindingTable.k_buffer_resource;
    cmd_buf.binding_table.SRV_offsets[slot] = xx offset_bytes;
    cmd_buf.descriptors_dirty = true;
}

bind_srv_texture_view :: (cmd_buf: *CommandBuffer, view: *TextureView, slot: u32) {
    assert(slot < TOTAL_SRV_BINDINGS);
    cmd_buf.binding_table.SRV_textures[slot] = view.desc.texture;
    cmd_buf.binding_table.SRV_texture_views[slot] = view;
    cmd_buf.binding_table.SRV_subresources[slot] = DescriptorBindingTable.k_tex_resource;
    cmd_buf.descriptors_dirty = true;
}

bind_uav_buffer :: (cmd_buf: *CommandBuffer, buffer: *Buffer, slot: u32, offset_bytes: u32 = 0) {
    assert(slot < TOTAL_UAV_BINDINGS);
    cmd_buf.binding_table.UAV_buffers[slot] = buffer;
    cmd_buf.binding_table.UAV_subresources[slot] = DescriptorBindingTable.k_buffer_resource;
    cmd_buf.binding_table.UAV_offsets[slot] = xx offset_bytes;
    cmd_buf.descriptors_dirty = true;
}

bind_uav_texture_view :: (cmd_buf: *CommandBuffer, view: *TextureView, slot: u32) {
    assert(slot < TOTAL_UAV_BINDINGS);
    cmd_buf.binding_table.UAV_textures[slot] = view.desc.texture;
    cmd_buf.binding_table.UAV_texture_views[slot] = view;
    cmd_buf.binding_table.UAV_subresources[slot] = DescriptorBindingTable.k_tex_resource;
    cmd_buf.descriptors_dirty = true;
}

bind_pipeline :: (cmd_buf: *CommandBuffer, pipeline: *Pipeline) {
    cmd_buf.bound_pipeline = pipeline;
    vkCmdBindPipeline(cmd_buf.vk_cmd_buffer, VkPipelineBindPoint.GRAPHICS, pipeline.vk_pipeline);
}

draw :: (cmd_buf: *CommandBuffer, device: *Device, bind_pool: *BindPool,
         vertex_count: u32, first_vertex: u32 = 0,  instance_count: u32 = 1, first_instance: u32 = 0) {
    flush_binds(cmd_buf, device, bind_pool);
    vkCmdDraw(cmd_buf.vk_cmd_buffer, vertex_count, instance_count, first_vertex, first_instance);
}

#import "Vulkan";
#import "graphics/rhi";
