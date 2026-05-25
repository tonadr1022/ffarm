RHIDeviceSettings :: struct {
    validation_layers_enabled: bool;
    exit_on_validation_layer_error: bool;
}

RHISurface :: struct {
    _handle: u64;
}

RHIDevice :: struct {
    using specific: DeviceBackend;
}

RHICommandQueue :: struct {
    using specific: CommandQueue;
}

RHICommandPool :: struct {
    using specific: CommandPool;
}

RHISwapchain :: struct {
    using specific: SwapchainBackend;
}
