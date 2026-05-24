WindowBackend :: struct {
    sdl_window: *SDL_Window;
    device: *RHIDevice;
    surface: *void;
}

window_init :: (win: *Window, title: string, width: s32, height: s32) -> bool {
    using window := *win.specific;
    window.sdl_window = SDL_CreateWindow(temp_c_string(title), width, height, 0);
    if window.sdl_window == null {
        print("Failed to create window: %\n", to_string(SDL_GetError()));
        return false;
    }
    return true;
}

// TODO: gate behind vulkan build flag
#if true {

window_device_init :: (win: *Window, rhi_device: *RHIDevice) {
    using window := *win.specific;
    window.device = rhi_device;

    vk_surface: VkSurfaceKHR;
    if !SDL_Vulkan_CreateSurface(window.sdl_window, rhi_device.specific.instance, null, *vk_surface) {
        print("Failed to create Vulkan surface: %\n", to_string(SDL_GetError()));
    }
    assert(vk_surface != null);
    window.surface = xx vk_surface;
}

window_device_deinit :: (win: *Window) {
    assert(win.specific.surface != null);
    assert(win.specific.device.specific.instance != null);
    SDL_Vulkan_DestroySurface(win.specific.device.specific.instance, win.specific.surface, null);
}

}