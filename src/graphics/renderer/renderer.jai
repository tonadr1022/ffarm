Renderer :: struct {
    device: RHI.Device;
    window: *Window;
    swapchain: RHI.Swapchain;

    gfx_cmd_pools: [..]RHI.CommandPool;
    // todo: compute cmd pools
}

renderer: Renderer;

renderer_init :: (window: *Window) {
    settings: RHI.DeviceSettings = .{exit_on_validation_layer_error=true, validation_layers_enabled=true};
    RHI.device_init(*renderer.device, *settings);
    renderer.window = window;
    assert(renderer.window.sdl_window != null);
    renderer.window.surface = RHI.create_surface(*renderer.device, renderer.window.sdl_window);
    w, h := window_get_size(renderer.window);
    vsync :: true;
    RHI.swapchain_init(*renderer.swapchain, *renderer.device, renderer.window.surface, w, h, vsync);
    print("Renderer initialized\n");
}

renderer_shutdown :: () { 
    RHI.swapchain_destroy(*renderer.swapchain);
    RHI.destroy_surface(*renderer.device, renderer.window.surface);
    RHI.device_free(*renderer.device);
}

renderer_do_render :: () {

}

RHI :: #import "graphics/rhi";
#import "Basic";
