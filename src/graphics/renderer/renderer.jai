Renderer :: struct {
    device: RHI.Device;
    window: *Window;
    swapchain: RHI.Swapchain;

    gfx_cmd_pools: [MAX_FRAMES_IN_FLIGHT]RHI.CommandPool;
    frames_in_flight: u32;
    curr_frame_in_flight_idx: u32;
    curr_frame_number: u64;
    // todo: compute cmd pools
}

renderer: Renderer;

init :: (window: *Window) {
    using,except (window) renderer;
    renderer.window = window;
    curr_frame_in_flight_idx = 0;
    curr_frame_number = 0;

    frames_in_flight = 3;
    settings: RHI.DeviceSettings = .{
        exit_on_validation_layer_error=true,
        validation_layers_enabled=true,
        frames_in_flight = frames_in_flight
    };
    RHI.device_init(*device, *settings);
    assert(window.sdl_window != null);
    window.surface = RHI.create_surface(*device, window.sdl_window);
    win_size_w, win_size_h := window_get_size(window);
    vsync :: true;
    RHI.swapchain_init(*swapchain, *device, window.surface, win_size_w, win_size_h, vsync);
    print("Renderer initialized\n");
    for 0..frames_in_flight-1 {
        RHI.command_pool_init(*gfx_cmd_pools[it], *device, RHI.QueueFamily.GRAPHICS);
    }

}

shutdown :: () { 
    using renderer;
    curr_frame_number = 0;
    curr_frame_in_flight_idx = 0;
    for 0..frames_in_flight-1 {
        RHI.command_pool_destroy(*gfx_cmd_pools[it], *device);
    }
    RHI.swapchain_destroy(*swapchain);
    RHI.destroy_surface(*device, window.surface);
    RHI.device_free(*device);
}

do_render :: () {
    using renderer;
    cmd_buf := RHI.command_pool_alloc_buf(*gfx_cmd_pools[curr_frame_in_flight_idx], *device);
}

#scope_file

MAX_FRAMES_IN_FLIGHT :: 3;

#scope_export

#import "platform";
RHI :: #import "graphics/rhi";
#import "Basic";
