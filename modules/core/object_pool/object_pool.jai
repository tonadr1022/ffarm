Pool_Handle :: struct {
    index: u32;
    generation: Generation;
}

ObjectPool :: struct (T: Type) {
    SlotT :: struct {
        data: T;
        generation: Generation;
    }
    HandleT :: #type,isa Pool_Handle;

    elements: [..]SlotT;
    free_slots: [..]u32;
}

is_valid :: (handle: Pool_Handle) -> bool {
    return handle.generation > 0;
}

obj_pool_alloc :: (pool: *ObjectPool($T)) -> ObjectPool(T).HandleT {
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

    return ObjectPool(T).HandleT.{index=xx slot_idx, generation=generation};
}

obj_pool_free :: (pool: *ObjectPool($T), handle: ObjectPool(T).HandleT)  {
    array_add(*pool.free_slots, handle.index);
}

get :: (pool: *ObjectPool($T), handle: ObjectPool(T).HandleT) -> *T {
    if handle.generation == 0 return null;
    if handle.index > pool.elements.count return null;
    slot := *pool.elements[handle.index];
    if handle.generation != slot.generation return null;
    return *slot.data;
}


#scope_file

Generation :: #type,isa s32;

#import "Basic";