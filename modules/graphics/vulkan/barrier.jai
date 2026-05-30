texture_barrier :: (cmd_buf: *CommandBuffer, desc: *TextureBarrierDesc) {
    descs: [1]TextureBarrierDesc = .[desc.*];
    texture_barriers(cmd_buf, descs);
}

texture_barriers :: (cmd_buf: *CommandBuffer, descs: []TextureBarrierDesc) {
    if descs.count == 0 return;

    barriers: [16]VkImageMemoryBarrier;
    assert(descs.count <= barriers.count);

    src_stages: VkPipelineStageFlags = 0;
    dst_stages: VkPipelineStageFlags = 0;

    for desc, i : descs {
        assert(desc.before == desc.texture.current_state);
        src_access, dst_access := transition_access(desc.before, desc.after);
        src_stage := state_stage(desc.before);
        dst_stage := state_stage(desc.after);
        if desc.src_stage src_stage = convert(desc.src_stage);
        if desc.dst_stage dst_stage = convert(desc.dst_stage);

        src_stages |= src_stage;
        dst_stages |= dst_stage;

        barriers[i] = VkImageMemoryBarrier.{
            srcAccessMask = src_access,
            dstAccessMask = dst_access,
            oldLayout = state_layout(desc.before),
            newLayout = state_layout(desc.after),
            srcQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED,
            dstQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED,
            image = desc.texture.vk_image,
            subresourceRange = VkImageSubresourceRange.{
                aspectMask = VkImageAspectFlags.COLOR,
                levelCount = 1,
                layerCount = 1,
            },
        };
        desc.texture.current_state = desc.after;
    }

    vkCmdPipelineBarrier(
        cmd_buf.vk_cmd_buffer,
        src_stages,
        dst_stages,
        0,
        0, null,
        0, null,
        xx descs.count, barriers.data
    );
}

#scope_file

state_layout :: (state: TextureState) -> VkImageLayout {
    if state == {
        case .UNDEFINED; return VkImageLayout.UNDEFINED;
        case .PRESENT; return VkImageLayout.PRESENT_SRC_KHR;
        case .COLOR_RENDER_TARGET; return VkImageLayout.COLOR_ATTACHMENT_OPTIMAL;
        case .DEPTH_STENCIL_WRITE; return VkImageLayout.DEPTH_STENCIL_ATTACHMENT_OPTIMAL;
        case .DEPTH_STENCIL_READ; return VkImageLayout.DEPTH_STENCIL_READ_ONLY_OPTIMAL;
        case .SHADER_READ; return VkImageLayout.SHADER_READ_ONLY_OPTIMAL;
        case .SHADER_WRITE; return VkImageLayout.GENERAL;
        case .COPY_SRC; return VkImageLayout.TRANSFER_SRC_OPTIMAL;
        case .COPY_DST; return VkImageLayout.TRANSFER_DST_OPTIMAL;
    }
    return VkImageLayout.UNDEFINED;
}

state_stage :: (state: TextureState) -> VkPipelineStageFlags {
    if state == {
        case .UNDEFINED; return VkPipelineStageFlags.TOP_OF_PIPE;
        case .PRESENT; return VkPipelineStageFlags.BOTTOM_OF_PIPE;
        case .COLOR_RENDER_TARGET; return VkPipelineStageFlags.COLOR_ATTACHMENT_OUTPUT;
        case .DEPTH_STENCIL_WRITE; return VkPipelineStageFlags.EARLY_FRAGMENT_TESTS | VkPipelineStageFlags.LATE_FRAGMENT_TESTS;
        case .DEPTH_STENCIL_READ; return VkPipelineStageFlags.FRAGMENT_SHADER;
        case .SHADER_READ; return VkPipelineStageFlags.FRAGMENT_SHADER | VkPipelineStageFlags.COMPUTE_SHADER | VkPipelineStageFlags.VERTEX_SHADER;
        case .SHADER_WRITE; return VkPipelineStageFlags.COMPUTE_SHADER | VkPipelineStageFlags.FRAGMENT_SHADER;
        case .COPY_SRC; return VkPipelineStageFlags.TRANSFER;
        case .COPY_DST; return VkPipelineStageFlags.TRANSFER;
    }
    return VkPipelineStageFlags.TOP_OF_PIPE;
}

state_access :: (state: TextureState) -> VkAccessFlags {
    if state == {
        case .UNDEFINED; return 0;
        case .PRESENT; return 0;
        case .COLOR_RENDER_TARGET; return VkAccessFlags.COLOR_ATTACHMENT_WRITE;
        case .DEPTH_STENCIL_WRITE; return VkAccessFlags.DEPTH_STENCIL_ATTACHMENT_WRITE;
        case .DEPTH_STENCIL_READ; return VkAccessFlags.DEPTH_STENCIL_ATTACHMENT_READ;
        case .SHADER_READ; return VkAccessFlags.SHADER_READ;
        case .SHADER_WRITE; return VkAccessFlags.SHADER_WRITE;
        case .COPY_SRC; return VkAccessFlags.TRANSFER_READ;
        case .COPY_DST; return VkAccessFlags.TRANSFER_WRITE;
    }
    return 0;
}

transition_access :: (before: TextureState, after: TextureState) -> VkAccessFlags, VkAccessFlags {
    return state_access(before), state_access(after);
}

#import "graphics/rhi";
#import "Vulkan";
