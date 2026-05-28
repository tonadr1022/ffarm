begin_render_pass :: (cmd_buf: *CommandBuffer, pass_desc: *RenderPassDesc) { 
    vk_color_atts: [RenderPassDesc.max_color_attachments]VkRenderingAttachmentInfo;
    for color_att, i : pass_desc.color_attachments {
        vk_color_atts[i].imageView;
    }
    rendering_info := VkRenderingInfo.{
        renderArea = convert(pass_desc.render_area),
        layerCount = 1,
        colorAttachmentCount=vk_color_atts.count,
        pColorAttachments=vk_color_atts.data,
    };

//    vkCmdBeginRendering(cmd_buf.vk_cmd_buffer, *rendering_info);
}

end_render_pass :: (cmd_buf: *CommandBuffer) {
//    vkCmdEndRendering(cmd_buf.vk_cmd_buffer);
}

#import "Vulkan";
#import "graphics/rhi";
