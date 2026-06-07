#include "shader_core.h"
#include "shared_basic_tri.h"
#include "shared_shader_core.h"

struct FOut {
  float4 color : SV_Target0;
};

struct VOut {
  float4 pos : SV_Position;
  float2 uv : TEXCOORD0;
  float4 color : COLOR0;
};

Texture2D albedo : register(t1);
SamplerState samp : register(s103);

FOut main(VOut vout) {
  FOut result;
  result.color = albedo.Sample(samp, vout.uv) * vout.color;
  if (result.color.a < 0.1) {
    discard;
  }
  return result;
}
