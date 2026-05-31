// HiveObjectPool :: struct (T: Type, HandleT: Type) {
//     SlotT :: struct {
//         data: T;
//         generation: Generation;
//     }
//     BlockT :: struct {
//         slots: [..]SlotT;
//         free_slots: [..]u32;
//     }
//     blocks: [..]BlockT;
//     block_element_count: u32 = 512;
// }

// HandleT :: struct {
//     block_index: u32;
//     slot_index: u32;
//     generation: Generation;
// }

// // does not resize the blocks, only sets block size for future allocations
// hive_pool_set_block_element_count :: (pool: *HiveObjectPool($T, $HandleT), size: u32) {
//     pool.block_element_count = size;
// }

// hive_pool_alloc :: (pool: *HiveObjectPool($T, $HandleT)) -> HandleT {
//     // find first free slot
//     for * block: pool.blocks {
//         if block.free_slots.count > 0 {
//             block_idx := it_index;
//             slot_idx := block.free_slots.data[block.free_slots.count-1];
//             block.free_slots.count -= 1;
//             slot := *block.slots[slot_idx];
//             slot.generation += 1;
//             return HandleT.{block_index=xx block_idx, slot_index=xx slot_idx, generation=slot.generation};
//         }
//     }

//     // no free slots, new block
//     block := hive_pool_create_block(pool);
//     block_idx := pool.blocks.count-1;
//     slot_idx := block.free_slots.data[block.free_slots.count-1];
//     block.free_slots.count -= 1;
//     slot := *block.slots[slot_idx];
//     slot.generation += 1;
//     return HandleT.{block_index=xx block_idx, slot_index=xx slot_idx, generation=slot.generation};
// }

// hive_pool_free :: (pool: *HiveObjectPool($T, $HandleT), handle: HandleT)  {
//     block := *pool.blocks[handle.block_index];
//     array_add(*block.free_slots, handle.slot_index);
// }



// #scope_file

// hive_pool_create_block :: (pool: *HiveObjectPool($T, $HandleT)) -> *HiveObjectPool.BlockT {
//     block: HiveObjectPool.BlockT;
//     array_resize(*block.slots, pool.block_element_count);
//     i := pool.block_element_count-1;
//     while i >= 0 {
//         array_add(*block.free_slots, xx i);
//         i -= 1;
//     }
//     array_add(*pool.blocks, block);
//     return *pool.blocks[pool.blocks.count-1];
// }

// Generation :: #type,isa s32;