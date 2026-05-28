TextureBackend :: struct {
    vk_image: VkImage;
    vma_allocation: VmaAllocation;
}

TextureViewBackend :: struct {
    vk_image_view: VkImageView;
}

texture_init :: (tex: *Texture, desc: *TextureDesc, device: *Device) {
    assert(desc.size.width > 0 && desc.size.height > 0 && desc.size.depth > 0);
    cinfo := VkImageCreateInfo.{
        imageType = image_type_from_size(desc.size),
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

texture_destroy :: (tex: *Texture, device: *Device) {
    vmaDestroyImage(device.vma_allocator, tex.vk_image, tex.vma_allocation);
}

texture_view_init :: (tex_view: *TextureView, desc: *TextureViewDesc, device: *Device) {
    cinfo := VkImageViewCreateInfo.{
        image = desc.texture.vk_image,
        viewType = VkImageViewType.e2D,
        format = VkFormat.R32_SFLOAT,
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


image_type_from_size :: (size: Extent3D) -> VkImageType {
    if size.depth > 1
        return VkImageType.e3D;
    if size.height > 1
        return VkImageType.e2D;
    else
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
