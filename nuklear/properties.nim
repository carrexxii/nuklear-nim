using
    ctx : pointer
    name: cstring

proc nk_property_int*(ctx; name; min: cint; val: ptr cint; step: cint; inc_per_px: cfloat)                  {. importc: "nk_property_int"   .}
proc nk_property_float*(ctx; name; min: cfloat; val: ptr cfloat; max, step, inc_per_px: cfloat)             {. importc: "nk_property_float" .}
proc nk_property_double*(ctx; name; min: cdouble; val: ptr cdouble; max, step: cdouble; inc_per_px: cfloat) {. importc: "nk_property_double".}
proc nk_propertyi*(ctx; name; min, val, max, step: cint; inc_per_px: cfloat): cint                          {. importc: "nk_propertyi"      .}
proc nk_propertyf*(ctx; name; min, val, max, step, inc_per_px: cfloat): cfloat                              {. importc: "nk_propertyf"      .}
proc nk_propertyd*(ctx; name; min, val, max, step: cdouble; inc_per_px: cfloat): cdouble                    {. importc: "nk_propertyd"      .}
