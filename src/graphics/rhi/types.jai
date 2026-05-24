RHIDeviceSettings :: struct {
    validation_layers_enabled: bool;
    exit_on_validation_layer_error: bool;
}

RHIDevice :: struct {
    specific: DeviceBackend;
}

RHICommandQueue :: struct {
}
