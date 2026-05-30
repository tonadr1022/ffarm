
#ifdef __HLSL__

#define PASTE1(a, b) a##b
#define PASTE(a, b) PASTE1(a, b)
#define CONSTANT_BUFFER(type, name, reg)                                       \
  ConstantBuffer<type> name : register(PASTE(b, reg))

#if defined(VULKAN)
#define PUSHCONSTANT(type, name) [[vk::push_constant]] type name
#else
#define PUSHCONSTANT(type, name) CONSTANT_BUFFER(type, name, 998)
#endif // VULKAN

#endif
