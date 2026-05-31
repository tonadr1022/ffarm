pipeline_create :: (device: *Device, desc: *GraphicsPipelineDesc) -> *Pipeline {
    push_constants: [..]ReflectPushConstant;
    defer array_free(push_constants);
    layout_bindings: [..]VkDescriptorSetLayoutBinding;
    defer array_free(layout_bindings);
    bindless_usages: [..]BindlessBindingUsage;

    vert_bindings: [..]VkDescriptorSetLayoutBinding;
    defer array_free(vert_bindings);
    frag_bindings: [..]VkDescriptorSetLayoutBinding;
    defer array_free(frag_bindings);
    vert_pcs: [..]ReflectPushConstant;
    defer array_free(vert_pcs);
    frag_pcs: [..]ReflectPushConstant;
    defer array_free(frag_pcs);

    reflect_shader(desc.vertex_spirv, VkShaderStageFlags.VERTEX, *vert_pcs, *vert_bindings, *bindless_usages);
    reflect_shader(desc.fragment_spirv, VkShaderStageFlags.FRAGMENT, *frag_pcs, *frag_bindings, *bindless_usages);
    merge_push_constants(*push_constants, vert_pcs);
    merge_push_constants(*push_constants, frag_pcs);
    merge_layout_bindings(*layout_bindings, vert_bindings);
    merge_layout_bindings(*layout_bindings, frag_bindings);
    sort_layout_bindings(*layout_bindings);

    for * binding : layout_bindings {
        if binding.descriptorType == VkDescriptorType.SAMPLER && binding.binding >= 100 {
            sampler_index := binding.binding - 100;
            assert(sampler_index < device.static_samplers.count);
            binding.pImmutableSamplers = device.static_samplers.data + sampler_index;
        }
    }

    set_layout_info := VkDescriptorSetLayoutCreateInfo.{
        bindingCount = xx layout_bindings.count,
        pBindings = layout_bindings.data,
    };
    descriptor_set_layout: VkDescriptorSetLayout;
    VK_CHECK(vkCreateDescriptorSetLayout(device.device, *set_layout_info, null, *descriptor_set_layout));

    push_constant_ranges: [..]VkPushConstantRange;
    defer array_free(push_constant_ranges);
    for pc : push_constants {
        range := array_add(*push_constant_ranges);
        range.* = VkPushConstantRange.{
            stageFlags = pc.stage_flags,
            offset = pc.offset,
            size = pc.size,
        };
    }

    pipeline_layout_info := VkPipelineLayoutCreateInfo.{
        setLayoutCount = 1,
        pSetLayouts = *descriptor_set_layout,
        pushConstantRangeCount = xx push_constant_ranges.count,
        pPushConstantRanges = push_constant_ranges.data,
    };
    pipeline_layout: VkPipelineLayout;
    VK_CHECK(vkCreatePipelineLayout(device.device, *pipeline_layout_info, null, *pipeline_layout));

    vert_module := create_shader_module(device, desc.vertex_spirv);
    defer vkDestroyShaderModule(device.device, vert_module, null);
    frag_module := create_shader_module(device, desc.fragment_spirv);
    defer vkDestroyShaderModule(device.device, frag_module, null);

    stages := VkPipelineShaderStageCreateInfo.[
        .{
            stage = VkShaderStageFlags.VERTEX,
            module = vert_module,
            pName = "main",
        },
        .{
            stage = VkShaderStageFlags.FRAGMENT,
            module = frag_module,
            pName = "main",
        },
    ];

    vertex_input := VkPipelineVertexInputStateCreateInfo.{};
    input_assembly := VkPipelineInputAssemblyStateCreateInfo.{
        topology = VkPrimitiveTopology.TRIANGLE_LIST,
    };
    viewport_state := VkPipelineViewportStateCreateInfo.{
        scissorCount = 1,
        viewportCount = 1,
    };
    rasterizer := VkPipelineRasterizationStateCreateInfo.{
        polygonMode = VkPolygonMode.FILL,
        cullMode = VkCullModeFlags.NONE,
        frontFace = VkFrontFace.COUNTER_CLOCKWISE,
        lineWidth = 1.0,
    };
    multisample := VkPipelineMultisampleStateCreateInfo.{
        rasterizationSamples = VkSampleCountFlags.e1,
    };
    color_blend_attachment := VkPipelineColorBlendAttachmentState.{
        colorWriteMask = VkColorComponentFlags.R | .G | .B | .A,
    };
    color_blend := VkPipelineColorBlendStateCreateInfo.{
        attachmentCount = 1,
        pAttachments = *color_blend_attachment,
    };

    dynamic_states := VkDynamicState.[
        .VIEWPORT,
        .SCISSOR,
    ];
    dynamic_state := VkPipelineDynamicStateCreateInfo.{
        dynamicStateCount = xx dynamic_states.count,
        pDynamicStates = dynamic_states.data,
    };

    color_format := convert(desc.color_format);
    rendering_info := VkPipelineRenderingCreateInfo.{
        colorAttachmentCount = 1,
        pColorAttachmentFormats = *color_format,
    };

    pipeline_info := VkGraphicsPipelineCreateInfo.{
        pNext = *rendering_info,
        stageCount = xx stages.count,
        pStages = stages.data,
        pVertexInputState = *vertex_input,
        pInputAssemblyState = *input_assembly,
        pViewportState = *viewport_state,
        pRasterizationState = *rasterizer,
        pMultisampleState = *multisample,
        pColorBlendState = *color_blend,
        pDynamicState = *dynamic_state,
        layout = pipeline_layout,
        renderPass = null,
    };

    vk_pipeline: VkPipeline;
    VK_CHECK(vkCreateGraphicsPipelines(device.device, null, 1, *pipeline_info, null, *vk_pipeline));

    pipeline := New(Pipeline);
    pipeline.vk_pipeline = vk_pipeline;
    pipeline.pipeline_layout = pipeline_layout;
    pipeline.descriptor_set_layout = descriptor_set_layout;
    pipeline.is_compute = false;
    pipeline.bindless_usages = bindless_usages;
    array_copy(*pipeline.layout_bindings, layout_bindings);
    return pipeline;
}

pipeline_destroy :: (device: *Device, pipeline: *Pipeline) {
    if !pipeline return;
    vkDestroyPipeline(device.device, pipeline.vk_pipeline, null);
    vkDestroyPipelineLayout(device.device, pipeline.pipeline_layout, null);
    vkDestroyDescriptorSetLayout(device.device, pipeline.descriptor_set_layout, null);
    array_free(pipeline.layout_bindings);
    array_free(pipeline.bindless_usages);
    free(pipeline);
}

#scope_file

create_shader_module :: (device: *Device, spirv: []u8) -> VkShaderModule {
    create_info := VkShaderModuleCreateInfo.{
        codeSize = xx spirv.count,
        pCode = cast(*u32) spirv.data,
    };
    module: VkShaderModule;
    VK_CHECK(vkCreateShaderModule(device.device, *create_info, null, *module));
    return module;
}

#import "Vulkan";
#import "graphics/rhi";
