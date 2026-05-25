command_pool_init :: (pool: *CommandPool, device: *Device, queue: QueueFamily) {
    create_info: VkCommandPoolCreateInfo;
    create_info.flags = VkCommandPoolCreateFlags.RESET_COMMAND_BUFFER_BIT;
    create_info.queueFamilyIndex = device.queue_family_indices.graphics_queue_family_idx;
    VK_CHECK(vkCreateCommandPool(device.device, *create_info, null, *pool.pool));
}

command_pool_destroy :: (pool: *CommandPool, device: *Device) {
    vkDestroyCommandPool(device.device, pool.pool, null);
}

command_pool_alloc_buf :: (pool: *CommandPool) {

}
