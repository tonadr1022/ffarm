DeviceSettings :: struct {
    validation_layers_enabled: bool;
    exit_on_validation_layer_error: bool;
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

Swapchain :: struct {
    using specific: SwapchainBackend;
}
