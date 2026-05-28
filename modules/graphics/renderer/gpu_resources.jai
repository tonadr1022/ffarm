ObjectPool :: struct (T: Type, HandleT: Type) {
    SlotT :: struct {
        data: T;
        generation: Generation;
    }

    elements: [..]SlotT;
    free_slots: [..]u32;
}

obj_pool_alloc :: (pool: *ObjectPool($T, $HandleT)) -> HandleT {
    if pool.free_slots.count == 0 {
        old_size := pool.elements.count;
        new_size := max(1, pool.elements.count * 2);
        array_resize(*pool.elements, new_size);
        i : s64 = pool.elements.count-1;
        while i >= old_size {
            array_add(*pool.free_slots, xx i);
            i -= 1;
        }
    }
    slot_idx := pool.free_slots.data[pool.free_slots.count-1];
    array_unordered_remove_by_index(*pool.free_slots, pool.free_slots.count-1);
    pool.elements[slot_idx].generation += 1;
    generation := pool.elements[slot_idx].generation;

    return HandleT.{index=xx slot_idx, generation=generation};
}

obj_pool_free :: (pool: *ObjectPool($T, $HandleT), handle: HandleT)  {
    array_add(*pool.free_slots, handle.index);
}

get :: (pool: *ObjectPool($T, $HandleT), handle: Handle) -> *T {
    if handle.generation == 0 return null;
    if handle.index > pool.elements.count return null;
    slot := *pool.elements[handle.index];
    if handle.generation != slot.generation return null;
    return *slot.data;
}

Handle :: struct {
    index: u32;
    generation: Generation;
}

TextureHandle :: #type,isa Handle;
TextureViewHandle :: #type,isa Handle;
BufferHandle :: #type,isa Handle;


GpuResources :: struct {
    textures: ObjectPool(RHI.Texture, TextureHandle);
    texture_views: ObjectPool(RHI.TextureView, TextureViewHandle);
    buffers: ObjectPool(RHI.Buffer, BufferHandle);

    device: *RHI.Device;
}


gpu_resources_init :: (device: *RHI.Device) {
    gpu_resources.device = device;
}

gpu_resources_destroy :: (resources: *GpuResources) {
    // destroy resources
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

Generation :: #type,isa s32;

RHI :: #import "graphics/rhi";
gpu_resources: GpuResources;
