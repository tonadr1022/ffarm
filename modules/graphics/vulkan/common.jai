VK_CHECK :: (result: VkResult) {
    if result != VkResult.SUCCESS {
        print("Vulkan error: %", result);
        exit(1);
    }
}
