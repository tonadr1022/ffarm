RHIDeviceSettings :: struct {
    validation_layers_enabled: bool;
    exit_on_validation_layer_error: bool;
}

RHIDevice :: struct {
    using specific: DeviceBackend;
}

RHICommandQueue :: struct {
}

RHISwapchain :: struct {
    using specific: SwapchainBackend;
}
