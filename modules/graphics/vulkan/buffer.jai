BufferBackend :: struct {
    vk_buffer: VkBuffer;
    vma_allocation: VmaAllocation;
    desc: BufferDesc;
}

buffer_init :: (buf: *Buffer, desc: *BufferDesc, device: *Device) {
    alloc_info: VmaAllocationCreateInfo;
    if desc.flags & BufferCreateFlags.HostVisible {
        alloc_info.flags = xx VmaAllocationCreateFlagBits.HOST_ACCESS_SEQUENTIAL_WRITE_BIT;
    }

    buffer_cinfo := VkBufferCreateInfo.{
        size = desc.size,
        usage = VkBufferUsageFlags.TRANSFER_DST | VkBufferUsageFlags.TRANSFER_SRC,
    };
    VK_CHECK(vmaCreateBuffer(device.vma_allocator, *buffer_cinfo, *alloc_info, *buf.vk_buffer, *buf.vma_allocation, null));
}

buffer_destroy :: (buf: *Buffer, device: *Device) {
    vmaDestroyBuffer(device.vma_allocator, buf.vk_buffer, buf.vma_allocation);
}

#scope_file

#import "jai-vma";
#import "graphics/rhi";
#import "Vulkan";

