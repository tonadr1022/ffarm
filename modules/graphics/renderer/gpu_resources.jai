GpuResources :: struct {
    textures: ObjectPool(RHI.Texture);
    texture_views: ObjectPool(RHI.TextureView);
    buffers: ObjectPool(RHI.Buffer);

    device: *RHI.Device;
}

TextureHandle :: ObjectPool(RHI.Texture).HandleT;
TextureViewHandle :: ObjectPool(RHI.TextureView).HandleT;
BufferHandle :: ObjectPool(RHI.Buffer).HandleT;


gpu_resources_init :: (device: *RHI.Device) {
    gpu_resources.device = device;
}

gpu_resources_destroy :: (resources: *GpuResources) {
    // destroy resources instead of letting caller leak them and have vulkan validation errors?
}

buffer_create :: (desc: *RHI.BufferDesc) -> BufferHandle {
    handle := obj_pool_alloc(*gpu_resources.buffers);
    buffer := get(*gpu_resources.buffers, handle);
    RHI.buffer_init(buffer, desc, gpu_resources.device);
    return handle;
}

buffer_destroy :: (handle: BufferHandle) {
    buffer := get(*gpu_resources.buffers, handle);
    assert(buffer != null);
    RHI.buffer_destroy(buffer, gpu_resources.device);
    obj_pool_free(*gpu_resources.buffers, handle);
}

get :: (handle: BufferHandle) -> *RHI.Buffer {
    return get(*gpu_resources.buffers, handle);
}

texture_create :: (desc: *RHI.TextureDesc) -> TextureHandle {
    handle := obj_pool_alloc(*gpu_resources.textures);
    resource := get(*gpu_resources.textures, handle);
    RHI.texture_init(resource, desc, gpu_resources.device);
    return handle;
}

texture_destroy :: (handle: TextureHandle) {
    resource := get(*gpu_resources.textures, handle);
    assert(resource != null);
    RHI.texture_destroy(resource, gpu_resources.device);
    obj_pool_free(*gpu_resources.textures, handle);
}

get :: (handle: TextureHandle) -> *RHI.Texture {
    return get(*gpu_resources.textures, handle);
}


texture_view_create :: (desc: *RHI.TextureViewDesc) -> TextureViewHandle {
    handle := obj_pool_alloc(*gpu_resources.texture_views);
    resource := get(*gpu_resources.texture_views, handle);
    RHI.texture_view_init(resource, desc, gpu_resources.device);
    return handle;
}

texture_view_destroy :: (handle: TextureViewHandle) {
    resource := get(*gpu_resources.texture_views, handle);
    assert(resource != null);
    RHI.texture_view_destroy(resource, gpu_resources.device);
    obj_pool_free(*gpu_resources.texture_views, handle);
}

get :: (handle: TextureViewHandle) -> *RHI.TextureView {
    return get(*gpu_resources.texture_views, handle);
}

#scope_file

RHI :: #import "graphics/rhi";
gpu_resources: GpuResources;

#import "core/object_pool";