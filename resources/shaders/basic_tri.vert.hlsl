#include "shader_core.h"
#include "shared_basic_tri.h"
#include "shared_shader_core.h"

struct VOut {
  float4 pos : SV_Position;
  float2 uv : TEXCOORD0;
  float3 color : TEXCOORD1;
};

StructuredBuffer<Vertex> vertices : register(t0);

VOut main(uint vert_id : SV_VertexID) {
  Vertex v = vertices[vert_id];
  VOut o;
  o.pos = float4(v.position, 1.0);
  o.uv = v.uv;
  o.color = v.color;
  return o;
}
