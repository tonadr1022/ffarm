Window :: struct {
    window: *SDL_Window;
    device: *RHIDevice;
    surface: *void;
}

window_init :: (window: *Window, title: string, width: s32, height: s32) -> bool {
    window.window = SDL_CreateWindow(temp_c_string(title), width, height, 0);
    if window.window == null {
        print("Failed to create window: %\n", to_string(SDL_GetError()));
        return false;
    }
    return true;
}

// TODO: gate behind vulkan build flag
#if true {

window_device_init :: (window: *Window, device: *RHIDevice) {
    window.device = device;
    surface: VkSurfaceKHR;
    SDL_Vulkan_CreateSurface(window.window, (cast(*DeviceData)device.backend_data).instance, null, *surface);
    window.surface = xx surface;
}

window_device_deinit :: (window: *Window) {
    SDL_Vulkan_DestroySurface((cast(*DeviceData)window.device.backend_data).instance, window.surface, null);
}

}