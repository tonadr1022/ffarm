#include "shader_core.h"

struct FOut {
  float4 color : SV_Target0;
};

struct VOut {
  float4 color;
};

FOut main(VOut vout) {
  FOut result;
  result.color = vout.color;
  return result;
}
