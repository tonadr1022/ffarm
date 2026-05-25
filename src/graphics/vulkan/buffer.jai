BufferBackend :: struct {
    vk_buffer: VkBuffer;
}

buffer_create :: () {
    vmaCreateBuffer();
}

#import "jai-vma";
#import "Vulkan";

