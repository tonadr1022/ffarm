SwapchainBackend :: struct {
    swapchain: VkSwapchainKHR;
    images: [..]VkImage;
    image_count: u32;
}

swapchain_init :: (using swapchain: *RHISwapchain, device: *RHIDevice, window: *Window) {
    using swap := *swapchain.specific;
}