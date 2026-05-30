cmd_begin :: (cmd_buf: *CommandBuffer, device: *Device) {
    begin_info := VkCommandBufferBeginInfo.{
        flags = VkCommandBufferUsageFlags.ONE_TIME_SUBMIT,
    };
    VK_CHECK(vkBeginCommandBuffer(cmd_buf.vk_cmd_buffer, *begin_info));
}

cmd_end :: (cmd_buf: *CommandBuffer) {
    VK_CHECK(vkEndCommandBuffer(cmd_buf.vk_cmd_buffer));
}

begin_render_pass :: (cmd_buf: *CommandBuffer, pass_desc: *RenderPassDesc) {
    vk_color_atts: [RenderPassDesc.max_color_attachments]VkRenderingAttachmentInfo;
    for i : 0..pass_desc.color_attachment_count-1 {
        att := pass_desc.color_attachments[i];
        assert(att.view != null);
        clear_val: VkClearValue;
        clear_val.color.float32_[0] = att.clear_color.x;
        clear_val.color.float32_[1] = att.clear_color.y;
        clear_val.color.float32_[2] = att.clear_color.z;
        clear_val.color.float32_[3] = att.clear_color.w;
        vk_color_atts[i] = VkRenderingAttachmentInfo.{
            imageView = att.view.vk_image_view,
            imageLayout = VkImageLayout.COLOR_ATTACHMENT_OPTIMAL,
            loadOp = convert(att.load_op),
            storeOp = convert(att.store_op),
            clearValue = clear_val,
        };
    }
    rendering_info := VkRenderingInfo.{
        renderArea = convert(pass_desc.render_area),
        layerCount = 1,
        colorAttachmentCount = pass_desc.color_attachment_count,
        pColorAttachments = vk_color_atts.data,
    };
    vkCmdBeginRendering(cmd_buf.vk_cmd_buffer, *rendering_info);
}

end_render_pass :: (cmd_buf: *CommandBuffer) {
    vkCmdEndRendering(cmd_buf.vk_cmd_buffer);
}

queue_submit :: (device: *Device, desc: *QueueSubmitDesc) {
    wait_sems: [8]VkSemaphore;
    wait_stages: [8]VkPipelineStageFlags;
    assert(desc.waits.count <= wait_sems.count);
    for i : 0..desc.waits.count-1 {
        wait_sems[i] = desc.waits[i].semaphore.semaphore;
        wait_stages[i] = convert(desc.waits[i].stage);
    }

    signal_sems: [8]VkSemaphore;
    for i : 0..desc.signal_semaphores.count-1 {
        signal_sems[i] = desc.signal_semaphores[i].semaphore;
    }

    cmd_bufs: [8]VkCommandBuffer;
    for i : 0..desc.cmd_buffers.count-1 {
        cmd_bufs[i] = desc.cmd_buffers[i].vk_cmd_buffer;
    }

    submit_info := VkSubmitInfo.{
        waitSemaphoreCount = xx desc.waits.count,
        pWaitSemaphores = wait_sems.data,
        pWaitDstStageMask = wait_stages.data,
        commandBufferCount = xx desc.cmd_buffers.count,
        pCommandBuffers = cmd_bufs.data,
        signalSemaphoreCount = xx desc.signal_semaphores.count,
        pSignalSemaphores = signal_sems.data,
    };

    fence: VkFence;
    if desc.fence != null {
        fence = desc.fence.fence;
    } else {
        fence = VK_NULL_HANDLE;
    }
    VK_CHECK(vkQueueSubmit(device.graphics_queue.queue, 1, *submit_info, fence));
}

copy_buffer_to_buffer :: (cmd_buf: *CommandBuffer, src_buf: *Buffer, dst_buf: *Buffer,
    size: u32, src_offset: u32 = 0, dst_offset: u32 = 0) {
    region := VkBufferCopy2.{
        size = size,
        srcOffset = src_offset,
        dstOffset = dst_offset,
    };
    copy_info := VkCopyBufferInfo2.{
        srcBuffer = src_buf.vk_buffer,
        dstBuffer = dst_buf.vk_buffer,
        regionCount = 1,
        pRegions = *region, 

    };
    vkCmdCopyBuffer2(cmd_buf.vk_cmd_buffer, *copy_info);
}

/*
upload_to_gpu_buffer :: (buf: *Buffer, device: Device, data: *$T, size: u32, src_offset: u32 = 0, dst_offset: u32 = 0) {
    copy: VkCopyBufferInfo2.{
        srcOffset = src_offset,
        dstOffset = dst_offset,
        size = size,
    };
    vkCmdCopyBuffer2();
}
*/

#scope_file

convert :: (op: LoadOp) -> VkAttachmentLoadOp {
    if op == {
        case .LOAD; return VkAttachmentLoadOp.LOAD;
        case .CLEAR; return VkAttachmentLoadOp.CLEAR;
        case .DONT_CARE; return VkAttachmentLoadOp.DONT_CARE;
    }
    return VkAttachmentLoadOp.DONT_CARE;
}

convert :: (op: StoreOp) -> VkAttachmentStoreOp {
    if op == {
        case .STORE; return VkAttachmentStoreOp.STORE;
        case .DONT_CARE; return VkAttachmentStoreOp.DONT_CARE;
    }
    return VkAttachmentStoreOp.DONT_CARE;
}

DescriptorBinderPool :: struct {
  pool: VkDescriptorPool;
  pool_size : u32 = 256;
};

DescriptorWrites :: struct {
    writes: [..]VkWriteDescriptorSet;
    img_infos: [..]VkDescriptorImageInfo;
    buf_infos: [..]VkDescriptorBufferInfo;
}

descriptor_binder_pool_init :: (dbp: *DescriptorBinderPool, vk_device: VkDevice) {
    pool_size := dbp.pool_size;
    pool_sizes := VkDescriptorPoolSize.[
        .{VkDescriptorType.UNIFORM_BUFFER, DESCRIPTOR_TABLE_CBV_COUNT * pool_size},
        .{VkDescriptorType.UNIFORM_BUFFER_DYNAMIC, DESCRIPTOR_TABLE_CBV_COUNT * pool_size},
        .{VkDescriptorType.STORAGE_BUFFER, TOTAL_SRV_BINDINGS * pool_size},
        .{VkDescriptorType.SAMPLED_IMAGE, TOTAL_SRV_BINDINGS * pool_size},
        .{VkDescriptorType.STORAGE_IMAGE, TOTAL_SRV_BINDINGS * pool_size},
        .{VkDescriptorType.STORAGE_IMAGE, TOTAL_UAV_BINDINGS * pool_size},
        .{VkDescriptorType.STORAGE_BUFFER, TOTAL_UAV_BINDINGS * pool_size},
        // TODO: separate sampler thing in table
        .{VkDescriptorType.SAMPLER, TOTAL_UAV_BINDINGS * pool_size},
    ];

    pool_info := VkDescriptorPoolCreateInfo.{
        maxSets = pool_size,
        poolSizeCount = pool_sizes.count,
        pPoolSizes = pool_sizes.data,
    };
    descriptor_binder_pool_destroy(dbp, vk_device);

    pool: VkDescriptorPool;
    VK_CHECK(vkCreateDescriptorPool(vk_device, *pool_info, nullptr, *pool));
}

descriptor_binder_pool_reset :: (dbp: *DescriptorBinderPool, vk_device: VkDevice) {
  VK_CHECK(vkResetDescriptorPool(vk_device, pool, 0));
}

descriptor_binder_pool_destroy :: (dbp: *DescriptorBinderPool, vk_device: VkDevice) {
    vkDestroyDescriptorPool(vk_device, dbp.pool, null);
}



#import "Vulkan";
#import "graphics/rhi";
