bind_pool_init :: (pool: *BindPool, device: *Device) {
    descriptor_binder_pool_init(pool, device);
}

bind_pool_reset :: (pool: *BindPool, device: *Device) {
    descriptor_binder_pool_reset(pool, device);
}

bind_pool_destroy :: (pool: *BindPool, device: *Device) {
    descriptor_binder_pool_destroy(pool, device);
}

DescriptorWrites :: struct {
    writes: [..]VkWriteDescriptorSet;
    img_infos: [..]VkDescriptorImageInfo;
    buf_infos: [..]VkDescriptorBufferInfo;
}

descriptor_writes_clear :: (w: *DescriptorWrites) {
    array_reset(*w.writes);
    array_reset(*w.img_infos);
    array_reset(*w.buf_infos);
}

descriptor_binder_pool_init :: (pool: *BindPool, device: *Device) {
    pool_size := pool.pool_size;
    pool_sizes := VkDescriptorPoolSize.[
        .{VkDescriptorType.UNIFORM_BUFFER, DESCRIPTOR_TABLE_CBV_COUNT * pool_size},
        .{VkDescriptorType.UNIFORM_BUFFER_DYNAMIC, DESCRIPTOR_TABLE_CBV_COUNT * pool_size},
        .{VkDescriptorType.STORAGE_BUFFER, TOTAL_SRV_BINDINGS * pool_size},
        .{VkDescriptorType.SAMPLED_IMAGE, TOTAL_SRV_BINDINGS * pool_size},
        .{VkDescriptorType.STORAGE_IMAGE, TOTAL_SRV_BINDINGS * pool_size},
        .{VkDescriptorType.STORAGE_IMAGE, TOTAL_UAV_BINDINGS * pool_size},
        .{VkDescriptorType.STORAGE_BUFFER, TOTAL_UAV_BINDINGS * pool_size},
        .{VkDescriptorType.SAMPLER, TOTAL_UAV_BINDINGS * pool_size},
    ];

    pool_info := VkDescriptorPoolCreateInfo.{
        maxSets = pool_size,
        poolSizeCount = pool_sizes.count,
        pPoolSizes = pool_sizes.data,
    };
    descriptor_binder_pool_destroy(pool, device);

    vk_pool: VkDescriptorPool;
    VK_CHECK(vkCreateDescriptorPool(device.device, *pool_info, null, *vk_pool));
    pool.pool = vk_pool;
}

descriptor_binder_pool_reset :: (pool: *BindPool, device: *Device) {
    assert(pool.pool != null);
    VK_CHECK(vkResetDescriptorPool(device.device, pool.pool, 0));
}

descriptor_binder_pool_destroy :: (pool: *BindPool, device: *Device) {
    if pool.pool {
        vkDestroyDescriptorPool(device.device, pool.pool, null);
        pool.pool = null;
    }
}

flush_binds :: (cmd_buf: *CommandBuffer, device: *Device, bind_pool: *BindPool) {
    if !cmd_buf.descriptors_dirty return;
    pipeline := cmd_buf.bound_pipeline;
    if !pipeline || pipeline.layout_bindings.count == 0 {
        cmd_buf.descriptors_dirty = false;
        return;
    }

    alloc_info := VkDescriptorSetAllocateInfo.{
        descriptorPool = bind_pool.pool,
        descriptorSetCount = 1,
        pSetLayouts = *pipeline.descriptor_set_layout,
    };

    descriptor_set: VkDescriptorSet;
    result: VkResult;
    while true {
        result = vkAllocateDescriptorSets(device.device, *alloc_info, *descriptor_set);
        if result == VkResult.ERROR_OUT_OF_POOL_MEMORY {
            bind_pool.pool_size *= 2;
            descriptor_binder_pool_init(bind_pool, device);
            alloc_info.descriptorPool = bind_pool.pool;
            continue;
        }
        break;
    }
    VK_CHECK(result);

    binder := *cmd_buf.binder;
    descriptor_writes_clear(binder);

    for * binding : pipeline.layout_bindings {
        if binding.pImmutableSamplers continue;

        write := array_add(*binder.writes);
        write.* = VkWriteDescriptorSet.{
            dstSet = descriptor_set,
            dstBinding = binding.binding,
            descriptorCount = binding.descriptorCount,
            descriptorType = binding.descriptorType,
        };

        if binding.descriptorType == {
            case VkDescriptorType.STORAGE_IMAGE; #through;
            case VkDescriptorType.SAMPLED_IMAGE; #through;
            case VkDescriptorType.COMBINED_IMAGE_SAMPLER;
                table_index: u32;
                layout: VkImageLayout;
                view: *TextureView;

                if binding.binding >= SRV_BINDING_BASE {
                    table_index = binding.binding - SRV_BINDING_BASE;
                    layout = VkImageLayout.SHADER_READ_ONLY_OPTIMAL;
                    assert(table_index < TOTAL_SRV_BINDINGS);
                    view = cmd_buf.binding_table.SRV_texture_views[table_index];
                } else if binding.binding >= UAV_BINDING_BASE {
                    table_index = binding.binding - UAV_BINDING_BASE;
                    layout = VkImageLayout.GENERAL;
                    assert(table_index < TOTAL_UAV_BINDINGS);
                    view = cmd_buf.binding_table.UAV_texture_views[table_index];
                } else {
                    assert(false);
                }
                assert(view != null);

                img_info := array_add(*binder.img_infos);
                img_info.* = VkDescriptorImageInfo.{
                    imageLayout = layout,
                    imageView = view.vk_image_view,
                };
                write.pImageInfo = img_info;
            case VkDescriptorType.STORAGE_BUFFER;
                table_index: u32;
                buf: *Buffer;
                offset: VkDeviceSize;

                if binding.binding >= CBV_BINDING_BASE {
                    assert(false);
                    table_index = binding.binding - CBV_BINDING_BASE;
                    assert(table_index < TOTAL_CBV_BINDINGS);
                    buf = cmd_buf.binding_table.CBV[table_index];
                    offset = xx cmd_buf.binding_table.CBV_offsets[table_index];
                } else if binding.binding >= SRV_BINDING_BASE {
                    table_index = binding.binding - SRV_BINDING_BASE;
                    assert(table_index < TOTAL_SRV_BINDINGS);
                    buf = cmd_buf.binding_table.SRV_buffers[table_index];
                    offset = xx cmd_buf.binding_table.SRV_offsets[table_index];
                } else if binding.binding >= UAV_BINDING_BASE {
                    table_index = binding.binding - UAV_BINDING_BASE;
                    assert(table_index < TOTAL_UAV_BINDINGS);
                    buf = cmd_buf.binding_table.UAV_buffers[table_index];
                    offset = xx cmd_buf.binding_table.UAV_offsets[table_index];
                } else {
                    assert(false);
                }
                assert(buf != null);

                buf_info := array_add(*binder.buf_infos);
                buf_info.* = VkDescriptorBufferInfo.{
                    buffer = buf.vk_buffer,
                    offset = offset,
                    range = VK_WHOLE_SIZE,
                };
                write.pBufferInfo = buf_info;

            case VkDescriptorType.UNIFORM_BUFFER;
                assert(binding.binding >= CBV_BINDING_BASE);
                table_index := binding.binding - CBV_BINDING_BASE;
                assert(table_index < TOTAL_CBV_BINDINGS);
                buf := cmd_buf.binding_table.CBV[table_index];
                assert(buf != null);

                buf_info := array_add(*binder.buf_infos);
                range := cmd_buf.binding_table.CBV_sizes[table_index];
                if range <= 0 range = xx buf.desc.size;
                buf_info.* = VkDescriptorBufferInfo.{
                    buffer = buf.vk_buffer,
                    offset = xx cmd_buf.binding_table.CBV_offsets[table_index],
                    range = xx range,
                };
                write.pBufferInfo = buf_info;

            case;
                assert(false);
        }
    }

    assert(binder.writes.count > 0);
    vkUpdateDescriptorSets(device.device, xx binder.writes.count, binder.writes.data, 0, null);
    bind_point := ifx pipeline.is_compute then VkPipelineBindPoint.COMPUTE else VkPipelineBindPoint.GRAPHICS;
    vkCmdBindDescriptorSets(cmd_buf.vk_cmd_buffer, bind_point, pipeline.pipeline_layout, 0, 1, *descriptor_set, 0, null);
    cmd_buf.descriptors_dirty = false;
}

#import "Vulkan";
#import "graphics/rhi";
