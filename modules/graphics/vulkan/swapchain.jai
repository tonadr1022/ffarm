SwapchainBackend :: struct {
    swapchain: VkSwapchainKHR;
    device: *Device;
    surface: SurfaceT;
    vk_format: VkFormat;
    vk_extent: VkExtent2D;
    images: [..]VkImage;
    back_buffers: [..]Texture;
    back_buffer_views: [..]TextureView;
}

swapchain_init :: (swapchain: *Swapchain, device: *Device, surface: SurfaceT, width: s32, height: s32, vsync: bool) {
    swapchain.device = device;
    swapchain.surface = surface;

    result := create_swapchain(device, surface, width, height, vsync, VK_NULL_HANDLE);
    swapchain.swapchain = result.swapchain;
    swapchain.vk_format = result.format;
    swapchain.vk_extent = result.extent;

    swapchain.format = convert_vk_format(result.format);
    swapchain.extent = .{width=result.extent.width, height=result.extent.height};

    init_back_buffers(swapchain, device);
    swapchain.image_count = xx swapchain.back_buffers.count;
}

swapchain_destroy :: (swapchain: *Swapchain) {
    for * swapchain.back_buffer_views {
        texture_view_destroy(it, swapchain.device);
    }
    array_free(swapchain.back_buffer_views);
    array_free(swapchain.back_buffers);
    array_free(swapchain.images);

    vkDestroySwapchainKHR(swapchain.device.device, swapchain.swapchain, null);
}

swapchain_get_texture :: (swapchain: *Swapchain, index: u32) -> *Texture {
    assert(index < swapchain.back_buffers.count);
    return *swapchain.back_buffers[index];
}

swapchain_get_view :: (swapchain: *Swapchain, index: u32) -> *TextureView {
    assert(index < swapchain.back_buffer_views.count);
    return *swapchain.back_buffer_views[index];
}

swapchain_acquire :: (swapchain: *Swapchain, device: *Device, acquire_sem: *Semaphore) -> SwapchainFrame {
    image_index: u32;
    VK_CHECK(vkAcquireNextImageKHR(
        device.device,
        swapchain.swapchain,
        U64_MAX,
        acquire_sem.semaphore,
        VK_NULL_HANDLE,
        *image_index
    ));

    tex := swapchain_get_texture(swapchain, image_index);
    view := swapchain_get_view(swapchain, image_index);

    return SwapchainFrame.{image_index=image_index, texture=tex, view=view};
}

swapchain_present :: (swapchain: *Swapchain, device: *Device, image_index: u32, wait_sem: *Semaphore) {
    wait_sems := wait_sem.semaphore;
    present_info := VkPresentInfoKHR.{
        waitSemaphoreCount = 1,
        pWaitSemaphores = *wait_sems,
        swapchainCount = 1,
        pSwapchains = *swapchain.swapchain,
        pImageIndices = *image_index,
    };
    VK_CHECK(vkQueuePresentKHR(device.graphics_queue.queue, *present_info));
}

// todo: handle swapchain resizing

#scope_file

SwapchainCreateResult :: struct {
    swapchain: VkSwapchainKHR;
    format: VkFormat;
    extent: VkExtent2D;
}

init_back_buffers :: (swapchain: *Swapchain, device: *Device) {
    image_count: u32;
    VK_CHECK(vkGetSwapchainImagesKHR(device.device, swapchain.swapchain, *image_count, null));
    array_resize(*swapchain.images, image_count);
    VK_CHECK(vkGetSwapchainImagesKHR(device.device, swapchain.swapchain, *image_count, swapchain.images.data));

    tex_desc := TextureDesc.{
        size=.{swapchain.vk_extent.width, swapchain.vk_extent.height, 1},
        format=swapchain.format,
        usage=TextureUsageFlags.COLOR_ATT,
    };

    array_resize(*swapchain.back_buffers, image_count);
    array_resize(*swapchain.back_buffer_views, image_count);

    for img, i : swapchain.images {
        tex := *swapchain.back_buffers[i];
        texture_init_external(tex, img, *tex_desc);

        view_desc := TextureViewDesc.{texture=tex};
        texture_view_init(*swapchain.back_buffer_views[i], *view_desc, device);
    }
}

is_srgb_format :: (format: VkFormat) -> bool {
    return format == VkFormat.B8G8R8A8_SRGB
        || format == VkFormat.R8_SRGB
        || format == VkFormat.R8G8_SRGB
        || format == VkFormat.B8G8R8_SRGB
        || format == VkFormat.R8G8B8A8_SRGB
        || format == VkFormat.B8G8R8A8_SRGB
        || format == VkFormat.A8B8G8R8_SRGB_PACK32;
}

create_swapchain :: (device: *Device, surface: SurfaceT, width: s32, height: s32, vsync: bool, old_swapchain: VkSwapchainKHR) -> SwapchainCreateResult {
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

    present_modes: [16]VkPresentModeKHR;
    present_modes_count: u32;
    VK_CHECK(vkGetPhysicalDeviceSurfacePresentModesKHR(device.physical_device, vk_surface, *present_modes_count, null));
    VK_CHECK(vkGetPhysicalDeviceSurfacePresentModesKHR(device.physical_device, vk_surface, *present_modes_count, present_modes.data));

    selected_present_mode: VkPresentModeKHR;
    if vsync {
        selected_present_mode = VkPresentModeKHR.FIFO;
    } else {
        selected_present_mode = VkPresentModeKHR.IMMEDIATE;
        for present_mode : present_modes {
            if present_mode == VkPresentModeKHR.MAILBOX {
                selected_present_mode = present_mode;
                break;
            }
        }
    }

    min_image_count := max(surface_capabilities.minImageCount, device.settings.frames_in_flight);

    create_info: VkSwapchainCreateInfoKHR = {
        flags = 0,
        surface = vk_surface,
        minImageCount = min_image_count,
        imageFormat = surface_formats[selected_surface_format].format,
        imageColorSpace = surface_formats[selected_surface_format].colorSpace,
        imageExtent = .{xx width, xx height},
        imageArrayLayers = 1,
        imageUsage = VkImageUsageFlags.COLOR_ATTACHMENT | VkImageUsageFlags.TRANSFER_DST,
        preTransform = VkSurfaceTransformFlagBitsKHR.IDENTITY,
        compositeAlpha = VkCompositeAlphaFlagBitsKHR.OPAQUE,
        presentMode = selected_present_mode,
        oldSwapchain = old_swapchain,
    };
    new_vk_swapchain: VkSwapchainKHR;
    VK_CHECK(vkCreateSwapchainKHR(device.device, *create_info, null, *new_vk_swapchain));
    if old_swapchain != VK_NULL_HANDLE {
        vkDestroySwapchainKHR(device.device, old_swapchain, null);
    }

    return SwapchainCreateResult.{
        swapchain=new_vk_swapchain,
        format=surface_formats[selected_surface_format].format,
        extent=.{width=xx width, height=xx height},
    };
}

#import "graphics/rhi";
#import "Vulkan";
#import "Math";
