DeviceSettings :: struct {
    validation_layers_enabled: bool;
    exit_on_validation_layer_error: bool;
    frames_in_flight: u32; // 2 or 3
}

SurfaceT :: struct {
    _handle: u64;
}

Device :: struct {
    using specific: DeviceBackend;
}

CommandQueue :: struct {
    using specific: CommandQueueBackend;
}

CommandPool :: struct {
    using specific: CommandPoolBackend;
}

CommandBuffer :: struct {
    using specific: CommandBufferBackend;
}

Swapchain :: struct {
    using specific: SwapchainBackend;
}

Buffer :: struct {
    using specific: BufferBackend;
}

QueueFamily :: enum_flags u32 {
    GRAPHICS :: 0;
    COMPUTE :: 1;
}
