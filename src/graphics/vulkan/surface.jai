#scope_file

surface_to_vk :: (surface: RHISurface) -> VkSurfaceKHR {
    return cast(VkSurfaceKHR) surface._handle;
}

#scope_export

rhi_create_surface :: (device: *RHIDevice, sdl_window: *SDL_Window) -> RHISurface {
    vk_surface: VkSurfaceKHR;
    if !SDL_Vulkan_CreateSurface(sdl_window, device.instance, null, *vk_surface) {
        print("Failed to create Vulkan surface: %\n", to_string(SDL_GetError()));
        exit(1);
    }
    assert(vk_surface != null);
    return .{_handle = xx vk_surface};
}

rhi_destroy_surface :: (device: *RHIDevice, surface: RHISurface) {
    vk_surface := surface_to_vk(surface);
    assert(vk_surface != null);
    assert(device.instance != null);
    SDL_Vulkan_DestroySurface(device.instance, vk_surface, null);
}
