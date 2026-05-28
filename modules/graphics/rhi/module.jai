#module_parameters (backend := Backend.VULKAN)() {
    Backend :: enum {
        VULKAN;
        // METAL;
    }
}

#scope_module
#import "Basic";

#import "jai-sdl3";

#load "types.jai";

#if backend == .VULKAN {
    #import "Vulkan";
    #load "../vulkan/helpers.jai";
    #load "../vulkan/common.jai";
    #load "../vulkan/device.jai";
    #load "../vulkan/surface.jai";
    #load "../vulkan/swapchain.jai";
    #load "../vulkan/command_pool.jai";
    #load "../vulkan/command_buffer.jai";
    #load "../vulkan/buffer.jai";
    #load "../vulkan/texture.jai";
} else {
    #assert false "Backend not implemented";
}
