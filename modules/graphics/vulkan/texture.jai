TextureBackend :: struct {
    vk_image: VkImage;
    vma_allocation: VmaAllocation;
    is_external: bool;
    bindless_index: u32 = k_invalid_bindless_index;
}

TextureViewBackend :: struct {
    vk_image_view: VkImageView;
}

texture_init :: (tex: *Texture, desc: *TextureDesc, device: *Device) {
    assert(desc.size.width > 0 && desc.size.height > 0 && desc.size.depth > 0);
    assert(tex != null);
    tex.desc = desc.*;
    tex.current_state = .UNDEFINED;
    tex.is_external = false;
    cinfo := VkImageCreateInfo.{
        imageType = image_type_from_dimension(desc.dimension),
        format = convert(desc.format),
        extent = convert(desc.size),
        mipLevels = desc.mip_levels,
        arrayLayers = desc.array_layers,
        samples = VkSampleCountFlags.e1,
        tiling = VkImageTiling.OPTIMAL,
        usage = VkImageUsageFlags.TRANSFER_DST | VkImageUsageFlags.TRANSFER_SRC | convert(desc.usage),
        sharingMode = VkSharingMode.EXCLUSIVE,
        initialLayout = VkImageLayout.UNDEFINED,
    };
    alloc_cinfo := VmaAllocationCreateInfo.{
        usage = VmaMemoryUsage.AUTO_PREFER_DEVICE,
    };
    VK_CHECK(vmaCreateImage(device.vma_allocator, *cinfo, *alloc_cinfo, *tex.vk_image, *tex.vma_allocation, null));
}

texture_init_external :: (tex: *Texture, vk_image: VkImage, desc: *TextureDesc) {
    tex.is_external = true;
    tex.vk_image = vk_image;
    tex.desc = desc.*;
    tex.current_state = .UNDEFINED;
}

texture_destroy :: (tex: *Texture, device: *Device) {
    if tex.is_external return;
    vmaDestroyImage(device.vma_allocator, tex.vk_image, tex.vma_allocation);
}

texture_view_init :: (tex_view: *TextureView, desc: *TextureViewDesc, device: *Device) {
    tex_view.desc = desc.*;
    cinfo := VkImageViewCreateInfo.{
        image = desc.texture.vk_image,
        viewType = VkImageViewType.e2D,
        format = convert(desc.texture.desc.format),
        subresourceRange = VkImageSubresourceRange.{
            aspectMask = VkImageAspectFlags.COLOR,
            levelCount = 1,
            layerCount = 1,
        }
    };
    VK_CHECK(vkCreateImageView(device.device, *cinfo, null, *tex_view.vk_image_view));
}

texture_view_destroy :: (tex_view: *TextureView, device: *Device) {
    vkDestroyImageView(device.device, tex_view.vk_image_view, null);
}

#scope_file


image_type_from_dimension :: (dimension: TextureDimension) -> VkImageType {
    if dimension == .D3
        return VkImageType.e3D;
    if dimension == .D2
        return VkImageType.e2D;
    return VkImageType.e1D;
}

convert :: (usage: TextureUsageFlags) -> VkImageUsageFlags {
    result: VkImageUsageFlags = 0;
    if usage & TextureUsageFlags.COLOR_ATT
        result |= VkImageUsageFlags.COLOR_ATTACHMENT;
    if usage & TextureUsageFlags.DEPTH_STENCIL_ATT
        result |= VkImageUsageFlags.DEPTH_STENCIL_ATTACHMENT;
    if usage & TextureUsageFlags.STORAGE
        result |= VkImageUsageFlags.STORAGE;
    if usage & TextureUsageFlags.SAMPLED
        result |= VkImageUsageFlags.SAMPLED;

    return result;
}

#import "jai-vma";
#import "graphics/rhi";
#import "Vulkan";
