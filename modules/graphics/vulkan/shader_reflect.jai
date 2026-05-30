ReflectPushConstant :: struct {
    stage_flags: VkShaderStageFlags;
    offset: u32;
    size: u32;
}

reflect_shader :: (spirv: []u8, stage: VkShaderStageFlags, push_constants: *[..]ReflectPushConstant, layout_bindings: *[..]VkDescriptorSetLayoutBinding, bindless_usages: *[..]BindlessBindingUsage) {
    module: SpvReflectShaderModule;
    result := spvReflectCreateShaderModule2(xx SpvReflectModuleFlagBits.NO_COPY, xx spirv.count, spirv.data, *module);
    assert(result == .SUCCESS);
    defer spvReflectDestroyShaderModule(*module);

    pc_count: u32;
    spvReflectEnumeratePushConstantBlocks(*module, *pc_count, null);
    if pc_count > 0 {
        blocks := cast(*SpvReflectBlockVariable) alloc(size_of(SpvReflectBlockVariable) * pc_count);
        block_ptr := blocks;
        spvReflectEnumeratePushConstantBlocks(*module, *pc_count, *block_ptr);
        for i : 0..pc_count-1 {
            pc := array_add(push_constants);
            pc.stage_flags = stage;
            pc.offset = blocks[i].offset;
            pc.size = blocks[i].size;
        }
        free(blocks);
    }

    set_count: u32;
    spvReflectEnumerateDescriptorSets(*module, *set_count, null);
    if set_count == 0 return;

    sets: [..]*SpvReflectDescriptorSet;
    defer array_free(sets);
    array_resize(*sets, set_count);
    spvReflectEnumerateDescriptorSets(*module, *set_count, sets.data);

    for i : 0..set_count-1 {
        set := sets[i];
        if set.set != 0 {
            while bindless_usages.count <= set.set - 1 array_add(bindless_usages);
            usage := *bindless_usages.*[set.set - 1];
            usage.used = true;
            usage.set_index = set.set;
            continue;
        }

        for j : 0..set.binding_count-1 {
            binding := set.bindings[j];
            vk_binding := array_add(layout_bindings);
            vk_binding.* = VkDescriptorSetLayoutBinding.{
                binding = binding.binding,
                descriptorType = cast(VkDescriptorType) binding.descriptor_type,
                descriptorCount = binding.count,
                stageFlags = stage,
            };
        }
    }
}

merge_layout_bindings :: (dst: *[..]VkDescriptorSetLayoutBinding, src: []VkDescriptorSetLayoutBinding) {
    for src_binding : src {
        found := false;
        for * existing : dst.* {
            if existing.binding == src_binding.binding && existing.descriptorType == src_binding.descriptorType {
                existing.stageFlags |= src_binding.stageFlags;
                found = true;
                break;
            }
        }
        if !found array_add(dst, src_binding);
    }
}

merge_push_constants :: (dst: *[..]ReflectPushConstant, src: []ReflectPushConstant) {
    for src_pc : src {
        found := false;
        for * existing : dst.* {
            if existing.offset == src_pc.offset && existing.size == src_pc.size {
                existing.stage_flags |= src_pc.stage_flags;
                found = true;
                break;
            }
        }
        if !found array_add(dst, src_pc);
    }
}

sort_layout_bindings :: (bindings: *[..]VkDescriptorSetLayoutBinding) {
    for i : 0..bindings.count-2 {
        for j : i+1..bindings.count-1 {
            if bindings.*[j].binding < bindings.*[i].binding {
                tmp := bindings.*[i];
                bindings.*[i] = bindings.*[j];
                bindings.*[j] = tmp;
            }
        }
    }
}

#import "Basic";
#import "Vulkan";
#import "graphics/rhi";
#import "jai-spirv-reflect";
