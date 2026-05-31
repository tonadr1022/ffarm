cmd_begin :: (cmd_buf: *CommandBuffer, device: *Device) {
    begin_info := VkCommandBufferBeginInfo.{
        flags = VkCommandBufferUsageFlags.ONE_TIME_SUBMIT,
    };
    VK_CHECK(vkBeginCommandBuffer(cmd_buf.vk_cmd_buffer, *begin_info));
}

cmd_end :: (cmd_buf: *CommandBuffer) {
    VK_CHECK(vkEndCommandBuffer(cmd_buf.vk_cmd_buffer));
}

push_constants :: (cmd_buf: *CommandBuffer, size: u32, data: *void, offset: u32 = 0) {
    vkCmdPushConstants(cmd_buf.vk_cmd_buffer, cmd_buf.bound_pipeline.pipeline_layout,
        VkShaderStageFlags.ALL_GRAPHICS, offset, size, data);
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

set_viewport_scissor :: (cmd_buf: *CommandBuffer, extent: Extent2D, offset: Offset2D = Offset2D.{0, 0}) {
    viewport := VkViewport.{
        x = cast(float) offset.x,
        y = cast(float)extent.height - offset.y,
        width = cast(float) extent.width,
        height = -cast(float) extent.height,
        maxDepth = 1.0,
    };
    scissor := VkRect2D.{extent = convert(extent)};
    vkCmdSetViewport(cmd_buf.vk_cmd_buffer, 0, 1, *viewport);
    vkCmdSetScissor(cmd_buf.vk_cmd_buffer, 0, 1, *scissor);
}

copy_buffer_to_texture :: (cmd_buf: *CommandBuffer, src_buf: *Buffer, dst_tex: *Texture, size_bytes: u32) {
    region := VkBufferImageCopy2.{
        bufferOffset = 0,
        bufferRowLength = 0,
        bufferImageHeight = 0,
        imageSubresource = VkImageSubresourceLayers.{
            aspectMask = VkImageAspectFlags.COLOR,
            mipLevel = 0,
            baseArrayLayer = 0,
            layerCount = 1,
        },
        imageOffset = .{0, 0, 0},
        imageExtent = convert(dst_tex.desc.size),
    };
    copy_info := VkCopyBufferToImageInfo2.{
        srcBuffer = src_buf.vk_buffer,
        dstImage = dst_tex.vk_image,
        dstImageLayout = VkImageLayout.TRANSFER_DST_OPTIMAL,
        regionCount = 1,
        pRegions = *region,
    };
    vkCmdCopyBufferToImage2(cmd_buf.vk_cmd_buffer, *copy_info);
}

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

convert :: (extent: Extent2D) -> VkExtent2D {
    return .{width = extent.width, height = extent.height};
}

#import "Vulkan";
#import "graphics/rhi";
