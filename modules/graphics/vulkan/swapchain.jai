SwapchainBackend :: struct {
    swapchain: VkSwapchainKHR;
    images: [..]VkImage;
    image_count: u32;
    device: VkDevice;
}

swapchain_init :: (swapchain: *Swapchain, device: *Device, surface: SurfaceT, width: s32, height: s32, vsync: bool) {
    swapchain.device = device.device;
    vk_swapchain := create_swapchain(device, surface, width, height, vsync, VK_NULL_HANDLE);
    swapchain.swapchain = vk_swapchain;
}

swapchain_destroy :: (swapchain: *Swapchain) {
    vkDestroySwapchainKHR(swapchain.device, swapchain.swapchain, null);
}

// todo: handle swapchain resizing

#scope_file

is_srgb_format :: (format: VkFormat) -> bool {
    // TODO: compressed formats
    return format == VkFormat.B8G8R8A8_SRGB
        || format == VkFormat.R8_SRGB
        || format == VkFormat.R8G8_SRGB
        || format == VkFormat.B8G8R8_SRGB
        || format == VkFormat.R8G8B8A8_SRGB
        || format == VkFormat.B8G8R8A8_SRGB
        || format == VkFormat.A8B8G8R8_SRGB_PACK32;
}

create_swapchain :: (device: *Device, surface: SurfaceT, width: s32, height: s32, vsync: bool, old_swapchain: VkSwapchainKHR) -> VkSwapchainKHR {
    vk_surface := cast(VkSurfaceKHR) surface._handle;

    surface_capabilities: VkSurfaceCapabilitiesKHR;
    VK_CHECK(vkGetPhysicalDeviceSurfaceCapabilitiesKHR(device.physical_device, vk_surface, *surface_capabilities));

    surface_formats: [..]VkSurfaceFormatKHR;
    defer array_free(surface_formats);
    surface_formats_count: u32;
    VK_CHECK(vkGetPhysicalDeviceSurfaceFormatsKHR(device.physical_device, vk_surface, *surface_formats_count, null));
    array_resize(*surface_formats, surface_formats_count);
    VK_CHECK(vkGetPhysicalDeviceSurfaceFormatsKHR(device.physical_device, vk_surface, *surface_formats_count, surface_formats.data));

    selected_surface_format := -1;
    for format, idx : surface_formats {
        if is_srgb_format(format.format) {
            selected_surface_format = idx;
            break;
        }
    }
    if selected_surface_format < 0 {
        selected_surface_format = 0;
    }

    // select present mode
    present_modes: [16]VkPresentModeKHR;
    present_modes_count: u32;
    VK_CHECK(vkGetPhysicalDeviceSurfacePresentModesKHR(device.physical_device, vk_surface, *present_modes_count, null));
    VK_CHECK(vkGetPhysicalDeviceSurfacePresentModesKHR(device.physical_device, vk_surface, *present_modes_count, present_modes.data));

    selected_present_mode: VkPresentModeKHR;
    if vsync {
        selected_present_mode = VkPresentModeKHR.IMMEDIATE;
    } else {
        selected_present_mode = VkPresentModeKHR.FIFO;
        for present_mode : present_modes {
            if present_mode == VkPresentModeKHR.MAILBOX {
                selected_present_mode = present_mode;
                break;
            }
        }
    }

    create_info: VkSwapchainCreateInfoKHR = {
        flags = 0,
        surface = vk_surface,
        minImageCount = surface_capabilities.minImageCount,
        imageFormat = surface_formats[selected_surface_format].format,
        imageColorSpace = surface_formats[selected_surface_format].colorSpace,
        imageExtent = .{xx width, xx height},
        imageArrayLayers = 1,
        imageUsage = VkImageUsageFlags.COLOR_ATTACHMENT | VkImageUsageFlags.TRANSFER_DST,
        preTransform = VkSurfaceTransformFlagBitsKHR.IDENTITY,
        compositeAlpha = VkCompositeAlphaFlagBitsKHR.OPAQUE,
        // queueFamilyIndexCount = 0, TODO: this might be needed?
        // pQueueFamilyIndices = null,
        presentMode = selected_present_mode,
        oldSwapchain = old_swapchain,
    };
    new_vk_swapchain: VkSwapchainKHR;
    VK_CHECK(vkCreateSwapchainKHR(device.device, *create_info, null, *new_vk_swapchain));
    if old_swapchain != VK_NULL_HANDLE {
        vkDestroySwapchainKHR(device.device, old_swapchain, null);
    }
    return new_vk_swapchain;
}
