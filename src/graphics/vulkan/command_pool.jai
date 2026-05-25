command_pool_init :: (pool: *CommandPool, device: *Device, queue: *CommandQueue) {
    create_info: VkCommandPoolCreateInfo;
    create_info.flags = VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT;
    create_info.queueFamilyIndex = queue.queue_family_index;
    VK_CHECK(vkCreateCommandPool(device.device, *create_info, null, *pool.pool));
}
