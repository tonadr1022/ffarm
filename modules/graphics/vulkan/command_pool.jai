CommandPoolBackend :: struct {
    pool: VkCommandPool;
    queue_family_index: u32;
}

command_pool_init :: (pool: *CommandPool, device: *Device, queue: QueueFamily) {
    create_info: VkCommandPoolCreateInfo;
    create_info.flags = VkCommandPoolCreateFlags.RESET_COMMAND_BUFFER;
    create_info.queueFamilyIndex = device.queue_family_indices.graphics_queue_family_idx;
    VK_CHECK(vkCreateCommandPool(device.device, *create_info, null, *pool.pool));
}

command_pool_reset :: (pool: *CommandPool, device: *Device) {
    VK_CHECK(vkResetCommandPool(device.device, pool.pool, 0));
}

command_pool_destroy :: (pool: *CommandPool, device: *Device) {
    vkDestroyCommandPool(device.device, pool.pool, null);
}

command_pool_alloc_buf :: (pool: *CommandPool, device: *Device) -> CommandBuffer {
    info := VkCommandBufferAllocateInfo.{
        commandPool = pool.pool,
        level = VkCommandBufferLevel.PRIMARY,
        commandBufferCount = 1,
    };
    vk_cmd_buf: VkCommandBuffer;
    VK_CHECK(vkAllocateCommandBuffers(device.device, *info, *vk_cmd_buf));
    return .{vk_cmd_buffer=vk_cmd_buf};
}

#import "Vulkan";
