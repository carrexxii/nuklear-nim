import common

using
    ctx  : ptr Context
    name : cstring
    title: cstring

{.push importc, cdecl.}
proc nk_begin*(ctx; title; bounds: Rect; flags: PanelFlag): bool
proc nk_begin_titled*(ctx; name, title; bounds: Rect; flags: PanelFlag): bool
proc nk_end*(ctx)

proc nk_window_find*(ctx; name)
proc nk_window_get_bounds*(ctx): Rect
proc nk_window_get_position*(ctx): Vec2
proc nk_window_get_size*(ctx): Vec2
proc nk_window_get_width*(ctx): cfloat
proc nk_window_get_height*(ctx): cfloat
proc nk_window_get_panel*(ctx): ptr Panel
proc nk_window_get_content_region*(ctx): Rect
proc nk_window_get_content_region_min*(ctx): Vec2
proc nk_window_get_content_region_max*(ctx): Vec2
proc nk_window_get_content_region_size*(ctx): Vec2
proc nk_window_get_canvas*(ctx): ptr CommandBuffer
proc nk_window_get_scroll*(ctx; x_offset, y_offset: ptr uint32)
proc nk_window_has_focus*(ctx): bool
proc nk_window_is_hovered*(ctx): bool
proc nk_window_is_collapsed*(ctx; name): bool
proc nk_window_is_closed*(ctx; name): bool
proc nk_window_is_hidden*(ctx; name): bool
proc nk_window_is_active*(ctx; name): bool
proc nk_window_is_any_hovered*(ctx): bool
proc nk_window_is_any_active*(ctx): bool
proc nk_window_set_bounds*(ctx; name; bounds: Rect)
proc nk_window_set_position*(ctx; name; pos: Vec2)
proc nk_window_set_size*(ctx; name; sz: Vec2)
proc nk_window_set_focus*(ctx; name)
proc nk_window_set_scroll*(ctx; name; x_offset, y_offset: uint32)
proc nk_window_close*(ctx; name)
proc nk_window_collapse*(ctx; name; state: CollapseState)
proc nk_window_collapse_if*(ctx; name; state: CollapseState; cond: cint)
proc nk_window_show*(ctx; name; state: ShowState)
proc nk_window_show_if*(ctx; name; state: ShowState; cond: cint)

proc nk_rule_horizontal*(ctx; colour: Colour; rounding: bool)

proc nk_group_begin*(ctx; name; flags: WindowFlag): bool
proc nk_group_begin_titled*(ctx; name, title; flags: WindowFlag): bool
proc nk_group_end*(ctx)
proc nk_group_scrolled_offset_begin*(ctx; x_offset, y_offset: ptr uint32; title; flags: WindowFlag)
proc nk_group_scrolled_begin*(ctx; offset: ptr Scroll; title; flags: WindowFlag)
proc nk_group_scrolled_end*(ctx)
proc nk_group_get_scroll*(ctx; id: cstring; x_offset, y_offset: ptr uint32)
proc nk_group_set_scroll*(ctx; id: cstring; x_offset, y_offset: uint32)
{.pop.}

#[ -------------------------------------------------------------------- ]#

using
    ctx  : var Context
    title: string
    name : string

{.push inline.}

proc start*(ctx; bounds: tuple[x, y, w, h: SomeFloat]; flags: PanelFlag; name, title = ""): bool =
    let bounds = Rect(x: bounds.x, y: bounds.y, w: bounds.w, h: bounds.h)
    if title.len > 0:
        nk_begin ctx.addr, cstring name, bounds, flags
    else:
        nk_begin_titled ctx.addr, cstring name, cstring title, bounds, flags

proc stop*(ctx) =
    nk_end ctx.addr

proc hr*(ctx; w: SomeNumber; h: SomeNumber = 1.5; colour = Colour(r: 112, g: 112, b: 112, a: 127); rounding = false) =
    ctx.row 1, h, w
    nk_rule_horizontal ctx.addr, colour, rounding

# proc nk_group_scrolled_offset_begin*(ctx; x_offset, y_offset: ptr uint32; title; flags: Flag)
# proc nk_group_scrolled_begin*(ctx; offset: ptr Scroll; title; flags: Flag)
# proc nk_group_scrolled_end*(ctx)
# proc nk_group_get_scroll*(ctx; id: cstring; x_offset, y_offset: ptr uint32)
# proc nk_group_set_scroll*(ctx; id: cstring; x_offset, y_offset: uint32)
proc start_group*(ctx; name; flags: WindowFlag): bool        = nk_group_begin        ctx.addr, cstring name, flags
proc start_group*(ctx; name; title; flags: WindowFlag): bool = nk_group_begin_titled ctx.addr, cstring name, cstring title, flags
proc stop_group*(ctx) = nk_group_end ctx.addr

{.pop.}
