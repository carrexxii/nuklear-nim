import common

using
    ctx : ptr Context
    name: cstring

{.push importc, cdecl.}
proc nk_property_int*(ctx; name; min: cint; val: ptr cint; max: cint; step: cint; inc_per_px: cfloat)
proc nk_property_float*(ctx; name; min: cfloat; val: ptr cfloat; max, step, inc_per_px: cfloat)
proc nk_property_double*(ctx; name; min: cdouble; val: ptr cdouble; max, step: cdouble; inc_per_px: cfloat)
proc nk_propertyi*(ctx; name; min, val, max, step: cint; inc_per_px: cfloat): cint
proc nk_propertyf*(ctx; name; min, val, max, step, inc_per_px: cfloat): cfloat
proc nk_propertyd*(ctx; name; min, val, max, step: cdouble; inc_per_px: cfloat): cdouble
{.pop.}

using
    ctx : var Context
    name: string

{.push inline.}

proc property*(ctx; name; val: int32; range: Slice[SomeInteger]; step = 1'i32; inc_per_px = 0.5'f32): int32 =
    nk_propertyi ctx.addr, cstring name, cint range.a, val, cint range.b, step, inc_per_px
proc property*(ctx; name; val: float32; range: Slice[SomeFloat]; step = 1'f32; inc_per_px = 0.5'f32): float32 =
    nk_propertyf ctx.addr, cstring name, cfloat range.a, val, cfloat range.b, step, inc_per_px
proc property*(ctx; name; val: float; range: Slice[SomeInteger]; step = 1'f64; inc_per_px = 0.5'f32): float =
    nk_propertyd ctx.addr, cstring name, cdouble range.a, val, cdouble range.b, step, inc_per_px

proc property*(ctx; name; val: var int32; range: Slice[SomeInteger]; step = 1'i32; inc_per_px = 0.5'f32) =
    nk_property_int ctx.addr, cstring name, cint range.a, val.addr, cint range.b, step, inc_per_px
proc property*(ctx; name; val: var float32; range: Slice[SomeFloat]; step = 1'f32; inc_per_px = 0.5'f32) =
    nk_property_float ctx.addr, cstring name, cfloat range.a, val.addr, cfloat range.b, step, inc_per_px
proc property*(ctx; name; val: var float; range: Slice[SomeInteger]; step = 1'f64; inc_per_px = 0.5'f32) =
    nk_property_int ctx.addr, cstring name, cdouble range.a, val.addr, cdouble range.b, step, inc_per_px

{.pop.}
