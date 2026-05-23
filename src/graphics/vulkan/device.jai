#import "Vulkan";

VK_CHECK :: (result: VkResult) {
    if result != VkResult.SUCCESS {
        print("Vulkan error: %", result);
        exit(1);
    }
}

Device :: struct {
    instance: VkInstance;
    physical_device: VkPhysicalDevice;
    device: VkDevice;
    debug_messenger: VkDebugUtilsMessengerEXT;

    graphics_queue: CommandQueue;
}

DebugCallbackData :: struct {
    exit_on_error: bool;
}

CommandQueue :: struct {
    queue: VkQueue;
    queue_family_index: u32;
}

CommandPool :: struct {
    pool: VkCommandPool;
    queue_family_index: u32;
}



debug_callback_data: DebugCallbackData;

device_init :: (settings: *DeviceSettings) -> Device {
    device: Device;

    enabled_layers: [..]*u8;
    defer array_free(enabled_layers);
    enabled_extensions: [..]*u8;
    defer array_free(enabled_extensions);

    if settings.validation_layers_enabled {
        array_add(*enabled_layers, "VK_LAYER_KHRONOS_validation");
        array_add(*enabled_extensions, VK_EXT_DEBUG_UTILS_EXTENSION_NAME);
    }

    app_info: VkApplicationInfo;
    app_info.apiVersion = VK_API_VERSION_1_0;

    create_info: VkInstanceCreateInfo;
    create_info.pApplicationInfo = *app_info;
    create_info.enabledLayerCount = xx enabled_layers.count;
    create_info.ppEnabledLayerNames = enabled_layers.data;
    create_info.enabledExtensionCount = xx enabled_extensions.count;
    create_info.ppEnabledExtensionNames = enabled_extensions.data;

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

    if settings.validation_layers_enabled {
        debug_callback_data.exit_on_error = settings.exit_on_validation_layer_error;
        debug_callback :: (message_severity: VkDebugUtilsMessageSeverityFlagsEXT, message_type: VkDebugUtilsMessageTypeFlagsEXT, pCallbackData: *VkDebugUtilsMessengerCallbackDataEXT, pUserData: *void) -> VkBool32 #c_call  {
            push_context {
                print("[VALIDATION_LAYER] %\n", to_string(pCallbackData.pMessage));
                data := cast(*DebugCallbackData) pUserData;
                if data.exit_on_error exit(1);
            }
            return VK_FALSE;
        }

        debug_create_info: VkDebugUtilsMessengerCreateInfoEXT;
        debug_create_info.messageSeverity = VkDebugUtilsMessageSeverityFlagsEXT.WARNING_BIT_EXT 
            | VkDebugUtilsMessageSeverityFlagsEXT.ERROR_BIT_EXT;
        debug_create_info.messageType = VkDebugUtilsMessageTypeFlagsEXT.GENERAL_BIT_EXT
            | VkDebugUtilsMessageTypeFlagsEXT.VALIDATION_BIT_EXT
            | VkDebugUtilsMessageTypeFlagsEXT.PERFORMANCE_BIT_EXT;
        debug_create_info.pfnUserCallback = debug_callback;
        debug_create_info.pUserData = xx *debug_callback_data;

        create_debug_utils_messenger := cast(PFN_vkCreateDebugUtilsMessengerEXT) vkGetInstanceProcAddr(device.instance, "vkCreateDebugUtilsMessengerEXT");
        assert(create_debug_utils_messenger != null);
        VK_CHECK(create_debug_utils_messenger(device.instance, *debug_create_info, null, *device.debug_messenger));
    }

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
        VK_CHECK(vkCreateDevice(device.physical_device, *dev_create_info, null, *device.device));
    }

    // just graphics queue for now
    queue_count: u32;
    vkGetPhysicalDeviceQueueFamilyProperties(device.physical_device, *queue_count, null);
    queue_family_properties: []VkQueueFamilyProperties;
    array_resize(*queue_family_properties, queue_count);
    defer array_free(queue_family_properties);
    vkGetPhysicalDeviceQueueFamilyProperties(device.physical_device, *queue_count, queue_family_properties.data);
    index := 0;
    for queue_family_property : queue_family_properties {
        if queue_family_property.queueFlags & VkQueueFlags.GRAPHICS_BIT {
            device.graphics_queue.queue_family_index = xx index;
            break;
        }
        index += 1;
    }
    vkGetDeviceQueue(device.device, device.graphics_queue.queue_family_index, 0, *device.graphics_queue.queue);

    return device;
}

device_free :: (device: *Device) {
    vkDestroyDevice(device.device, null);

    if device.debug_messenger {
        destroy_debug_utils_messenger := cast(PFN_vkDestroyDebugUtilsMessengerEXT) vkGetInstanceProcAddr(device.instance, "vkDestroyDebugUtilsMessengerEXT");
        if destroy_debug_utils_messenger {
            destroy_debug_utils_messenger(device.instance, device.debug_messenger, null);
        }
    }

    vkDestroyInstance(device.instance, null);
}