COMPILE_LIBRARY :: true;

SPIRV_REFLECT_DIR :: "../SPIRV-Reflect";
SOURCE_FILE :: "../SPIRV-Reflect/spirv_reflect.c";
LIB_BASE_NAME :: "libspirv_reflect";
LIB_DECLARATION_NAME :: "libspirv_reflect";

FUNCTIONS_TO_KEEP :: string.[
    "spvReflectCreateShaderModule2",
    "spvReflectDestroyShaderModule",
    "spvReflectEnumerateDescriptorSets",
    "spvReflectEnumeratePushConstantBlocks",
];

#run {
    set_build_options_dc(.{do_output = false});

    success: bool;
    #if COMPILE_LIBRARY {
        success = compile_spirv_reflect(OS, CPU);
        if !success {
            compiler_set_workspace_status(.FAILED);
            return;
        }
    }

    success = generate_bindings(OS, CPU);
    if !success compiler_set_workspace_status(.FAILED);
}

compile_spirv_reflect :: (os: Operating_System_Tag, cpu: CPU_Tag) -> bool {
    log("Compiling SPIRV-Reflect…");

    lib_directory: string;
    if os == {
        case .WINDOWS;  lib_directory = "windows";
        case .LINUX;    lib_directory = "linux";
        case .MACOS;    lib_directory = "macos";
        case;
            assert(false, "SPIRV-Reflect bindings: unsupported OS %", os);
            return false;
    }

    make_directory_if_it_does_not_exist(lib_directory);
    lib_path := tprint("%/%", lib_directory, LIB_BASE_NAME);

    include_path := get_absolute_path(SPIRV_REFLECT_DIR);
    extra: [..] string;
    array_add(*extra, "-I", include_path, "-x", "c");

    if os != .WINDOWS {
        array_add(*extra, "-fPIC");
    }

    if os == .MACOS {
        return build_cpp_static_lib(lib_path, SOURCE_FILE, extra = extra);
    }

    return build_cpp_static_lib(lib_path, SOURCE_FILE, target = os, extra = extra);
}

generate_bindings :: (target_os: Operating_System_Tag, target_cpu: CPU_Tag) -> bool {
    output_filename := "bindings.jai";
    options: Generate_Bindings_Options;
    options.os = target_os;
    options.cpu = target_cpu;

    lib_directory: string;
    if target_os == {
        case .WINDOWS;  lib_directory = "windows";
        case .LINUX;    lib_directory = "linux";
        case .MACOS;    lib_directory = "macos";
        case;
            assert(false);
            return false;
    }

    {
        using options;

        array_add(*library_search_paths, lib_directory);
        array_add(*libraries, .{filename = LIB_BASE_NAME, identifier = LIB_DECLARATION_NAME});

        include_path := get_absolute_path(SPIRV_REFLECT_DIR);
        array_add(*extra_clang_arguments, "-x", "c", "-I", include_path);
        array_add(*source_files, SOURCE_FILE);

        array_add(*system_include_paths, ..get_default_system_include_paths());

        alias_original_enum_names = false;
        log_stripped_declarations = false;
        auto_detect_enum_prefixes = true;
        generate_compile_time_struct_checks = true;

        generate_library_declarations = false;
        footer = SPIRV_REFLECT_FOOTER;
        visitor = spirv_reflect_visitor;
    }

    return generate_bindings(options, output_filename);
}

SPIRV_REFLECT_FOOTER :: #string END
#if OS == .WINDOWS {
    libspirv_reflect :: #library,no_dll "windows/libspirv_reflect";
} else #if OS == .LINUX {
    libspirv_reflect :: #library,no_dll "linux/libspirv_reflect";
} else #if OS == .MACOS {
    libspirv_reflect :: #library,no_dll "macos/libspirv_reflect";
} else {
    #assert false "Unsupported OS";
}
END

spirv_reflect_visitor :: (decl: *Declaration, parent_decl: *Declaration) -> Declaration_Visit_Result {
    name := decl.name;

    if begins_with(name, "spvReflect") {
        if !array_find(FUNCTIONS_TO_KEEP, name) {
            decl.decl_flags |= .OMIT_FROM_OUTPUT;
            return .STOP;
        }
    }

    return .RECURSE;
}

#import "Basic";
#import "Bindings_Generator";
#import "BuildCpp";
#import "Compiler";
#import "File";
#import "String";
