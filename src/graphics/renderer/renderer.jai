Renderer :: struct {
    device: RHIDevice;
    window: *Window;
}

renderer: Renderer;

renderer_init :: (window: *Window) {
    settings: RHIDeviceSettings = .{exit_on_validation_layer_error=true, validation_layers_enabled=true};
    device_init(*renderer.device, *settings);
    renderer.window = window;
    window_device_init(renderer.window, *renderer.device);
    print("Renderer initialized\n");
}

renderer_shutdown :: () { 
    window_device_deinit(renderer.window);
    device_free(*renderer.device);
}

#load "../rhi/device.jai";
#import "Basic";