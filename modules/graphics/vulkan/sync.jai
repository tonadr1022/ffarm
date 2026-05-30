SemaphoreBackend :: struct {
    semaphore: VkSemaphore;
}

FenceBackend :: struct {
    fence: VkFence;
}

semaphore_create :: (sem: *Semaphore, device: *Device) {
    cinfo := VkSemaphoreCreateInfo.{};
    VK_CHECK(vkCreateSemaphore(device.device, *cinfo, null, *sem.semaphore));
}

semaphore_destroy :: (sem: *Semaphore, device: *Device) {
    vkDestroySemaphore(device.device, sem.semaphore, null);
}

fence_create :: (fence: *Fence, device: *Device, signaled: bool) {
    flags: VkFenceCreateFlags;
    if signaled {
        flags = VkFenceCreateFlags.SIGNALED;
    } else {
        flags = 0;
    }
    cinfo := VkFenceCreateInfo.{
        flags = flags,
    };
    VK_CHECK(vkCreateFence(device.device, *cinfo, null, *fence.fence));
}

fence_destroy :: (fence: *Fence, device: *Device) {
    vkDestroyFence(device.device, fence.fence, null);
}

fence_wait :: (device: *Device, fence: *Fence, timeout_ns: u64) -> bool {
    result := vkWaitForFences(device.device, 1, *fence.fence, VK_TRUE, timeout_ns);
    return result == VkResult.SUCCESS;
}

fence_reset :: (device: *Device, fence: *Fence) {
    VK_CHECK(vkResetFences(device.device, 1, *fence.fence));
}

#import "graphics/rhi";
#import "Vulkan";
