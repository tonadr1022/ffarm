WindowBackend :: struct {
    sdl_window: *SDL_Window;
    device: *RHIDevice;
    // TODO: metal support
    surface: VkSurfaceKHR;
}

window_init :: (window: *Window, title: string, width: s32, height: s32) -> bool {
    window.sdl_window = SDL_CreateWindow(temp_c_string(title), width, height, 0);
    if window.sdl_window == null {
        print("Failed to create window: %\n", to_string(SDL_GetError()));
        return false;
    }
    return true;
}

window_get_size :: (window: *Window) -> s32, s32 {
    w: s32;
    h: s32;
    SDL_GetWindowSizeInPixels(window.sdl_window, *w, *h);
    return w, h;
}

// TODO: gate behind vulkan build flag
#if true {

window_device_init :: (window: *Window, rhi_device: *RHIDevice) {
    window.device = rhi_device;

    vk_surface: VkSurfaceKHR;
    if !SDL_Vulkan_CreateSurface(window.sdl_window, rhi_device.specific.instance, null, *vk_surface) {
        print("Failed to create Vulkan surface: %\n", to_string(SDL_GetError()));
    }
    assert(vk_surface != null);
    window.surface = vk_surface;
}

window_device_deinit :: (window: *Window) {
    assert(window.surface != null);
    assert(window.device.instance != null);
    SDL_Vulkan_DestroySurface(window.device.instance, window.surface, null);
}

}