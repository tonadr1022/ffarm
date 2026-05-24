command_pool_init :: (pool: *RHICommandPool, device: *RHIDevice, queue: *RHICommandQueue) {
    backend_data := cast(*DeviceData) device.backend_data;
    create_info: VkCommandPoolCreateInfo;
    create_info.flags = VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT;
    create_info.queueFamilyIndex = queue.queue_family_index;
    VK_CHECK(vkCreateCommandPool(backend_data.device, *create_info, null, *pool.pool));
}