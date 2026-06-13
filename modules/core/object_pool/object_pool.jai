Pool_Handle :: struct {
    index: u32;
    generation: Generation;
}

ObjectPool :: struct (T: Type) {
    SlotT :: struct {
        data: T;
        generation: Generation;
        occupied: bool;
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
        obj_pool_resize(pool, max(1, pool.elements.count * 2));
    }
    slot_idx := pool.free_slots.data[pool.free_slots.count-1];
    array_unordered_remove_by_index(*pool.free_slots, pool.free_slots.count-1);
    pool.elements[slot_idx].generation += 1;
    pool.elements[slot_idx].occupied = true;
    generation := pool.elements[slot_idx].generation;

    return ObjectPool(T).HandleT.{index=xx slot_idx, generation=generation};
}

obj_pool_free :: (pool: *ObjectPool($T), handle: ObjectPool(T).HandleT)  {
    array_add(*pool.free_slots, handle.index);
    pool.elements[handle.index].generation += 1;
    pool.elements[handle.index].occupied = false;
}

obj_pool_reserve :: (pool: *ObjectPool($T), count: int) {
    if count > pool.elements.count {
        obj_pool_resize(pool, count);
    }
}

get :: (pool: *ObjectPool($T), handle: ObjectPool(T).HandleT) -> *T {
    if handle.generation == 0 return null;
    if handle.index > pool.elements.count return null;
    slot := *pool.elements[handle.index];
    if handle.generation != slot.generation return null;
    return *slot.data;
}

for_expansion :: (pool: *ObjectPool($T), body: Code, flags: For_Flags) #expand {
    #assert(!(flags & .REVERSE));

    for * slot, idx: pool.elements {
        if !slot.occupied continue;

        #if flags & .POINTER {
            `it := *slot.data;
        } else {
            `it := slot.data;
        }

        `it_index := idx;
        `it_handle := ObjectPool(T).HandleT.{
            index=xx idx,
            generation=slot.generation,
        };

        #insert (remove={obj_pool_free(pool, `it_handle);}) body;
    }
}


#scope_file

obj_pool_resize :: (pool: *ObjectPool($T), new_size: int) {
    if new_size < pool.elements.count return;
    old_size := pool.elements.count;
    array_resize(*pool.elements, new_size);
    i : s64 = pool.elements.count-1;
    while i >= old_size {
        array_add(*pool.free_slots, xx i);
        i -= 1;
    }
}

Generation :: #type,isa s32;

#import "Basic";
