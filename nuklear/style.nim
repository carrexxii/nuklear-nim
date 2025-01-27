import common

using ctx: ptr Context

{.push importc, cdecl.}
proc nk_style_default*(ctx)
proc nk_style_from_table*(ctx; colour: ptr Colour)
proc nk_style_load_cursor*(ctx; style: StyleCursor; cursor: ptr Cursor)
proc nk_style_load_all_cursors*(ctx; cursor: ptr Cursor)
proc nk_style_get_color_by_name*(colours: StyleColours)
proc nk_style_set_font*(ctx; font: ptr UserFont)
proc nk_style_set_cursor*(ctx; style: StyleCursor)
proc nk_style_show_cursor*(ctx)
proc nk_style_hide_cursor*(ctx)

proc nk_style_push_font*(ctx; font: ptr UserFont): bool
proc nk_style_push_float*(ctx; dst: ptr cfloat; val: cfloat): bool
proc nk_style_push_vec2*(ctx; dst: ptr Vec2; val: Vec2): bool
proc nk_style_push_style_item*(ctx; dst: ptr StyleItem; val: StyleItem): bool
proc nk_style_push_flags*(ctx; dst: ptr uint32; val: uint32): bool
proc nk_style_push_color*(ctx; dst: ptr Colour; val: Colour): bool

proc nk_style_pop_font*(ctx): bool
proc nk_style_pop_float*(ctx): bool
proc nk_style_pop_vec2*(ctx): bool
proc nk_style_pop_style_item*(ctx): bool
proc nk_style_pop_flags*(ctx): bool
proc nk_style_pop_color*(ctx): bool

proc nk_style_item_color*(colour: Colour): StyleItem
proc nk_style_item_image*(img: Image): StyleItem
proc nk_style_item_nine_slice*(slice: NineSlice): StyleItem
proc nk_style_item_hide*(): StyleItem
{.pop.}

{.push inline.}

using ctx: var Context

proc show_cursor*(ctx) = nk_style_show_cursor ctx.addr
proc hide_cursor*(ctx) = nk_style_hide_cursor ctx.addr

proc style_item*(r, g, b: uint8; a = 255'u8): StyleItem = nk_style_item_color Colour(r: r, g: g, b: b, a: a)
proc style_item*(img: Image): StyleItem                 = nk_style_item_image img
proc style_item*(slice: NineSlice): StyleItem           = nk_style_item_nine_slice slice
proc style_item_hide*(): StyleItem                      = nk_style_item_hide()

proc push_style_font*(ctx; font: UserFont): bool                     {.discardable.} = nk_style_push_font       ctx.addr, font.addr
proc push_style_float*(ctx; dst: var cfloat; val: float32): bool     {.discardable.} = nk_style_push_float      ctx.addr, dst.addr, cfloat val
proc push_style_vec*(ctx; dst: var Vec2; val: Vec2): bool            {.discardable.} = nk_style_push_vec2       ctx.addr, dst.addr, val
proc push_style_item*(ctx; dst: var StyleItem; val: StyleItem): bool {.discardable.} = nk_style_push_style_item ctx.addr, dst.addr, val
proc push_style_flags*(ctx; dst: var uint32; val: uint32): bool      {.discardable.} = nk_style_push_flags      ctx.addr, dst.addr, val
proc push_style_colour*(ctx; dst: var Colour; val: Colour): bool     {.discardable.} = nk_style_push_color      ctx.addr, dst.addr, val

proc pop_style_font*(ctx): bool   {.discardable.} = nk_style_pop_font       ctx.addr
proc pop_style_float*(ctx): bool  {.discardable.} = nk_style_pop_float      ctx.addr
proc pop_style_vec*(ctx): bool    {.discardable.} = nk_style_pop_vec2       ctx.addr
proc pop_style_item*(ctx): bool   {.discardable.} = nk_style_pop_style_item ctx.addr
proc pop_style_flags*(ctx): bool  {.discardable.} = nk_style_pop_flags      ctx.addr
proc pop_style_colour*(ctx): bool {.discardable.} = nk_style_pop_color      ctx.addr

{.pop.}
