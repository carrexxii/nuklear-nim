import common

using ctx: ptr Context

{.push importc, cdecl.}
proc nk_layout_set_min_row_height*(ctx; h: cfloat)
proc nk_layout_reset_min_row_height*(ctx)
proc nk_layout_widget_bounds*(ctx): Rect
proc nk_layout_ratio_from_pixel*(ctx; px_w: cfloat): cfloat

proc nk_layout_row*(ctx; fmt: LayoutFormat; h: cfloat; cols: cint; ratio: ptr cfloat)
proc nk_layout_row_dynamic*(ctx; h: cfloat; cols: cint)
proc nk_layout_row_static*(ctx; h: cfloat; item_w, cols: cint)
proc nk_layout_row_begin*(ctx; fmt: LayoutFormat; h: cfloat; cols: cint)
proc nk_layout_row_push*(ctx; val: cfloat)
proc nk_layout_row_end*(ctx)

proc nk_layout_row_template_begin*(ctx; h: cfloat)
proc nk_layout_row_template_push_dynamic*(ctx)
proc nk_layout_row_template_push_variable*(ctx; min_w: cfloat)
proc nk_layout_row_template_push_static*(ctx; w: cfloat)
proc nk_layout_row_template_end*(ctx)

proc nk_layout_space_begin*(ctx; fmt: LayoutFormat; h: cfloat; widget_count: cint)
proc nk_layout_space_push*(ctx; bounds: Rect)
proc nk_layout_space_end*(ctx)
proc nk_layout_space_bounds*(ctx): Rect
proc nk_layout_space_to_screen*(ctx; pos: Vec2): Vec2
proc nk_layout_space_to_local*(ctx; pos: Vec2): Vec2
proc nk_layout_space_rect_to_screen*(ctx; rect: Rect): Rect
proc nk_layout_space_rect_to_local*(ctx; rect: Rect): Rect

proc nk_spacer*(ctx)
{.pop.}

#[ -------------------------------------------------------------------- ]#

using ctx: var Context

{.push inline.}

proc `min_row_height=`*(ctx; h: SomeNumber) = nk_layout_set_min_row_height ctx.addr, cfloat h

proc reset_min_row_height*(ctx) = nk_layout_reset_min_row_height ctx.addr

proc bounds*(ctx): Rect = nk_layout_widget_bounds ctx.addr

proc begin*(ctx; fmt: LayoutFormat; cols: SomeInteger; h: SomeNumber) {.deprecated.} =
    nk_layout_row_begin ctx.addr, fmt, cfloat h, cint cols

proc layout_row*(ctx; fmt: LayoutFormat; cols: int32; ratio: openArray[float32]; h = 0'f32) =
    assert cols <= ratio.len
    nk_layout_row ctx.addr, fmt, cfloat h, cint cols, ratio[0].addr
proc start_layout*(ctx; fmt: LayoutFormat; cols: int32; h = 0'f32) {.deprecated.} = nk_layout_row_begin ctx.addr, fmt, cfloat h, cint cols
proc static_row*(ctx; cols: int32; item_w: float32; h = 0'f32)     = nk_layout_row_static ctx.addr, cfloat h, cint item_w, cint cols
proc dynamic_row*(ctx; cols: int32; h = 0'f32)                     = nk_layout_row_dynamic ctx.addr, cfloat h, cint cols

proc start_row*(ctx; fmt: LayoutFormat; cols: int32; h = 0'f32) = nk_layout_row_begin ctx.addr, fmt, cfloat h, cint cols
proc stop_row*(ctx) = nk_layout_row_end ctx.addr

proc row*(ctx; cols: SomeInteger; h: SomeNumber; item_w: SomeNumber) {.deprecated.} = nk_layout_row_static  ctx.addr, cfloat h, cint item_w, cint cols
proc row*(ctx; cols: SomeInteger; h: SomeNumber)                     {.deprecated.} = nk_layout_row_dynamic ctx.addr, cfloat h, cint cols

proc push*(ctx; val: SomeNumber) {.deprecated.} =
    nk_layout_row_push ctx.addr, cfloat val

proc layout_push_row*(ctx; val: float32) {.deprecated.} =
    nk_layout_row_push ctx.addr, cfloat val

proc push_row*(ctx; val: float32) =
    nk_layout_row_push ctx.addr, cfloat val

proc start_row_template*(ctx; h = 0'f32)          = nk_layout_row_template_begin         ctx.addr, cfloat h
proc push_template_dynamic*(ctx)                  = nk_layout_row_template_push_dynamic  ctx.addr
proc push_template_variable*(ctx; min_w: float32) = nk_layout_row_template_push_variable ctx.addr, cfloat min_w
proc push_template_static*(ctx; w: float32)       = nk_layout_row_template_push_static   ctx.addr, cfloat w
proc stop_row_template*(ctx)                      = nk_layout_row_template_end           ctx.addr

proc start_space*(ctx; fmt: LayoutFormat; cnt: int32; h = 0'f32) =
    nk_layout_space_begin ctx.addr, fmt, cfloat h, cint cnt
proc push_space*(ctx; bounds: Rect) = nk_layout_space_push   ctx.addr, bounds
proc stop_space*(ctx)               = nk_layout_space_end    ctx.addr
proc space_bounds*(ctx): Rect       = nk_layout_space_bounds ctx.addr

proc space_to_screen*(ctx; pos: Vec2): Vec2  = nk_layout_space_to_screen      ctx.addr, pos
proc space_to_local*(ctx; pos: Vec2): Vec2   = nk_layout_space_to_local       ctx.addr, pos
proc space_to_screen*(ctx; rect: Rect): Rect = nk_layout_space_rect_to_screen ctx.addr, rect
proc space_to_local*(ctx; rect: Rect): Rect  = nk_layout_space_rect_to_local  ctx.addr, rect

#[ -------------------------------------------------------------------- ]#

template row_static*(ctx; cols: SomeInteger; h: SomeNumber; item_w: SomeNumber; body: untyped) = 
    row ctx, cols, h, item_w
    with ctx:
        body
template row_dynamic*(ctx; cols: SomeInteger; h: SomeNumber; body: untyped) = 
    row ctx, cols, h
    with ctx:
        body
template row_custom*(ctx: var Context; cols: SomeInteger; h: SomeNumber; body: untyped) =
    with ctx:
        begin lfStatic, cols, h
        body
        end_row

{.pop.}
