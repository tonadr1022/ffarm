#ifndef SHADER_CORE_H
#define SHADER_CORE_H

#define __HLSL__ 1
// TODO: dxc argument
#define VULKAN 1

#define ROOT_SIGNATURE                                                         \
  "RootFlags(CBV_SRV_UAV_HEAP_DIRECTLY_INDEXED | "                             \
  "SAMPLER_HEAP_DIRECTLY_INDEXED), "                                           \
  "RootConstants(num32BitConstants = 20, b998, space = 0, visibility = "       \
  "SHADER_VISIBILITY_ALL),"                                                    \
  "RootConstants(num32BitConstants = 2, b999, space = 0, visibility = "        \
  "SHADER_VISIBILITY_ALL),"                                                    \
  "CBV(b0, space = 0), "                                                       \
  "CBV(b1, space = 0), "                                                       \
  "CBV(b2, space = 0), "                                                       \
  "DescriptorTable( "                                                          \
  "CBV(b3, numDescriptors = 9, space = 0, flags = "                            \
  "DATA_STATIC_WHILE_SET_AT_EXECUTE),"                                         \
  "SRV(t0, numDescriptors = 12,space = 0,  flags = DESCRIPTORS_VOLATILE | "    \
  "DATA_STATIC_WHILE_SET_AT_EXECUTE),"                                         \
  "UAV(u0, numDescriptors = 12, flags = DESCRIPTORS_VOLATILE | "               \
  "DATA_STATIC_WHILE_SET_AT_EXECUTE)"                                          \
  "),"                                                                         \
  "StaticSampler(s100, addressU = TEXTURE_ADDRESS_CLAMP, addressV = "          \
  "TEXTURE_ADDRESS_CLAMP, "                                                    \
  "addressW = TEXTURE_ADDRESS_CLAMP, filter = FILTER_MIN_MAG_MIP_LINEAR),"     \
  "StaticSampler(s101, addressU = TEXTURE_ADDRESS_WRAP, addressV = "           \
  "TEXTURE_ADDRESS_WRAP, "                                                     \
  "addressW = TEXTURE_ADDRESS_WRAP, filter = FILTER_MIN_MAG_MIP_LINEAR),"      \
  "StaticSampler(s102, addressU = TEXTURE_ADDRESS_MIRROR, addressV = "         \
  "TEXTURE_ADDRESS_MIRROR, "                                                   \
  "addressW = TEXTURE_ADDRESS_MIRROR, filter = FILTER_MIN_MAG_MIP_LINEAR),"    \
  "StaticSampler(s103, addressU = TEXTURE_ADDRESS_CLAMP, addressV = "          \
  "TEXTURE_ADDRESS_CLAMP, "                                                    \
  "addressW = TEXTURE_ADDRESS_CLAMP, filter = FILTER_MIN_MAG_MIP_POINT),"      \
  "StaticSampler(s104, addressU = TEXTURE_ADDRESS_WRAP, addressV = "           \
  "TEXTURE_ADDRESS_WRAP, "                                                     \
  "addressW = TEXTURE_ADDRESS_WRAP, filter = FILTER_MIN_MAG_MIP_POINT),"       \
  "StaticSampler(s105, addressU = TEXTURE_ADDRESS_MIRROR, addressV = "         \
  "TEXTURE_ADDRESS_MIRROR, "                                                   \
  "addressW = TEXTURE_ADDRESS_MIRROR, filter = FILTER_MIN_MAG_MIP_POINT),"     \
  "StaticSampler(s106, addressU = TEXTURE_ADDRESS_CLAMP, addressV = "          \
  "TEXTURE_ADDRESS_CLAMP, "                                                    \
  "addressW = TEXTURE_ADDRESS_CLAMP, filter = FILTER_ANISOTROPIC, "            \
  "maxAnisotropy = 16),"                                                       \
  "StaticSampler(s107, addressU = TEXTURE_ADDRESS_WRAP, addressV = "           \
  "TEXTURE_ADDRESS_WRAP, "                                                     \
  "addressW = TEXTURE_ADDRESS_WRAP, filter = FILTER_ANISOTROPIC, "             \
  "maxAnisotropy = 16),"                                                       \
  "StaticSampler(s108, addressU = TEXTURE_ADDRESS_MIRROR, addressV = "         \
  "TEXTURE_ADDRESS_MIRROR, "                                                   \
  "addressW = TEXTURE_ADDRESS_MIRROR, filter = FILTER_ANISOTROPIC, "           \
  "maxAnisotropy = 16),"                                                       \
  "StaticSampler(s109, addressU = TEXTURE_ADDRESS_CLAMP, addressV = "          \
  "TEXTURE_ADDRESS_CLAMP, "                                                    \
  "addressW = TEXTURE_ADDRESS_CLAMP, filter = "                                \
  "FILTER_COMPARISON_MIN_MAG_LINEAR_MIP_POINT, "                               \
  "comparisonFunc = COMPARISON_GREATER_EQUAL),"

#endif
