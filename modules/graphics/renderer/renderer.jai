Renderer :: struct {
    device: RHI.Device;
    window: *Window;
    swapchain: RHI.Swapchain;

    // todo: compute cmd pools
    gfx_cmd_pools: [MAX_FRAMES_IN_FLIGHT]RHI.CommandPool;
    frames_in_flight: u32;
    curr_frame_in_flight_idx: u32;
    curr_frame_number: u64;

    tri_buffer: RHI.Buffer;
    test_buf: BufferHandle;
    test_tex: TextureHandle;
    test_img_view: TextureViewHandle;
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
    for 0..frames_in_flight-1 {
        RHI.command_pool_init(*gfx_cmd_pools[it], *device, RHI.QueueFamily.GRAPHICS);
    }

    // resources
    gpu_resources_init(*device);
    RHI.buffer_init(*tri_buffer, *(RHI.BufferDesc.{size=24}), *device);
    test_buf = buffer_create(*(RHI.BufferDesc.{size=24}));
    test_tex = texture_create(*(RHI.TextureDesc.{
        size=.{2,2,1},
        format=RHI.TextureFormat.R32_SFLOAT,
        usage=RHI.TextureUsageFlags.COLOR_ATT
    }));
    test_img_view = texture_view_create(*(RHI.TextureViewDesc.{
        texture=get(test_tex),
    }));

}

shutdown :: () { 
    using renderer;
    RHI.buffer_destroy(*tri_buffer, *device);
    buffer_destroy(test_buf);
    texture_view_destroy(test_img_view);
    texture_destroy(test_tex);
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

    // clear the swapchain texture
    pass_desc := RHI.RenderPassDesc.{render_area=.{offset=.{0,0},extent=.{10,10}}};
    RHI.begin_render_pass(*cmd_buf, *pass_desc);
    RHI.end_render_pass(*cmd_buf);
}

#scope_file

MAX_FRAMES_IN_FLIGHT :: 3;

RHI :: #import "graphics/rhi";
#import "platform";
#import "Basic";
