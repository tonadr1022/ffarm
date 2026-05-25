Renderer :: struct {
    device: RHIDevice;
    window: *Window;
    swapchain: RHISwapchain;
    // command_pools: [..]RHICommandPool;
}

renderer: Renderer;

renderer_init :: (window: *Window) {
    settings: RHIDeviceSettings = .{exit_on_validation_layer_error=true, validation_layers_enabled=true};
    device_init(*renderer.device, *settings);
    renderer.window = window;
    assert(renderer.window.sdl_window != null);
    renderer.window.surface = rhi_create_surface(*renderer.device, renderer.window.sdl_window);
    w, h := window_get_size(renderer.window);
    vsync :: true;
    swapchain_init(*renderer.swapchain, *renderer.device, renderer.window.surface, w, h, vsync);
    print("Renderer initialized\n");
}

renderer_shutdown :: () { 
    swapchain_destroy(*renderer.swapchain);
    rhi_destroy_surface(*renderer.device, renderer.window.surface);
    device_free(*renderer.device);
}

#import "graphics/rhi";
#import "Basic";
