#import "Basic";
#import("jai-sdl3");

#import "Vulkan";

VK_CHECK :: (result: VkResult) {
    if result != VkResult.SUCCESS {
        print("Vulkan error: %", result);
        exit(1);
    }
}


DeviceSettings :: struct {
    validation_layers_enabled: bool;
}

Device :: struct {
    instance: VkInstance;
    physical_device: VkPhysicalDevice;
    device: VkDevice;
}

device_init :: (settings: *DeviceSettings) -> Device {
    create_info: VkInstanceCreateInfo;
    device: Device;

    VK_CHECK(vkCreateInstance(*create_info, null, *device.instance));

    physical_device_count: u32;
    VK_CHECK(vkEnumeratePhysicalDevices(device.instance, *physical_device_count, null));
    physical_devices: []VkPhysicalDevice;
    array_resize(*physical_devices, physical_device_count);
    defer array_free(physical_devices);

    VK_CHECK(vkEnumeratePhysicalDevices(device.instance, *physical_device_count, physical_devices.data));

    try_select_phys_dev :: (physical_devices: []VkPhysicalDevice, device_type: VkPhysicalDeviceType) -> VkPhysicalDevice {
        for phys_dev : physical_devices {
            properties: VkPhysicalDeviceProperties;
            vkGetPhysicalDeviceProperties(phys_dev, *properties);
            if properties.deviceType == device_type {
                return phys_dev;
            }
        }
        return null;
    }

    selected_phys_dev := try_select_phys_dev(physical_devices, .DISCRETE_GPU);
    if !selected_phys_dev {
        selected_phys_dev = try_select_phys_dev(physical_devices, .INTEGRATED_GPU);
    }
    selected_phys_dev = physical_devices[0];
    device.physical_device = selected_phys_dev;

    properties: VkPhysicalDeviceProperties;
    vkGetPhysicalDeviceProperties(selected_phys_dev, *properties);
    print("Selected physical device: %\n", to_string(properties.deviceName));
    print("Device type: %\n", properties.deviceType);
    print("API version: %\n", properties.apiVersion);
    print("Driver version: %\n", properties.driverVersion);
    print("Vendor ID: %\n", properties.vendorID);
    print("Device ID: %\n", properties.deviceID);

    enabled_layers: [..]*u8;
    defer array_free(enabled_layers);

    if settings.validation_layers_enabled
        array_add(*enabled_layers, "VK_LAYER_KHRONOS_validation".data);

    {
        queue_create_info: VkDeviceQueueCreateInfo;
        queue_create_info.queueFamilyIndex = 0;
        queue_create_info.queueCount = 1;

        queue_priorities: [1]float = .[1.0];
        queue_create_info.pQueuePriorities = queue_priorities.data;

        queue_create_infos: [1]VkDeviceQueueCreateInfo = .[queue_create_info];
        dev_create_info: VkDeviceCreateInfo;
        dev_create_info.queueCreateInfoCount = queue_create_infos.count;
        dev_create_info.pQueueCreateInfos = queue_create_infos.data;
        dev_create_info.enabledExtensionCount = 0;
        dev_create_info.ppEnabledExtensionNames = null;
        dev_create_info.enabledLayerCount = xx enabled_layers.count;
        dev_create_info.ppEnabledLayerNames = enabled_layers.data;
        VK_CHECK(vkCreateDevice(device.physical_device, *dev_create_info, null, *device.device));
    }


    return device;
}

device_free :: (device: *Device) {
    vkDestroyDevice(device.device, null);
    vkDestroyInstance(device.instance, null);
}


main :: () {
    if !SDL_Init(SDL_InitFlags.VIDEO | SDL_InitFlags.EVENTS) {
        err_c_str := SDL_GetError();
        print("Failed to init SDL: %\n", string.{data=err_c_str, count=c_style_strlen(err_c_str)});
        exit(1);
    }
    window := SDL_CreateWindow("window", 800, 800, 0);
    settings: DeviceSettings;
    settings.validation_layers_enabled = true;
    device := device_init(*settings);
    defer device_free(*device);

    should_quit := false;

    while !should_quit {
        ev: SDL_Event;
        while (SDL_PollEvent(*ev)) {
            if ev.type == {
                case xx SDL_EventType.QUIT;
                    should_quit = true;
                case xx SDL_EventType.KEY_DOWN;
                    if ev.key.key == SDLK_ESCAPE
                        should_quit = true;
                case;
            }
        }
    }

    print("hello world!\n");
}
