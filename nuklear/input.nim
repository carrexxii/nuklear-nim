import common

using
    ctx  : ptr Context
    input: ptr Input
    rect : Rect

{.push importc, cdecl.}
proc nk_input_begin*(ctx)
proc nk_input_motion*(ctx; x, y: cint)
proc nk_input_key*(ctx; key: KeyKind; down: bool)
proc nk_input_button*(ctx; btn: Button; x, y: cint; down: bool)
proc nk_input_scroll*(ctx; val: Vec2)
proc nk_input_char*(ctx; c: char)
proc nk_input_glyph*(ctx; c: Glyph)
proc nk_input_unicode*(ctx; c: Rune)
proc nk_input_end*(ctx)

proc nk_input_has_mouse_click*(input; btn: Button): bool
proc nk_input_has_mouse_click_in_rect*(input; btn: Button; rect): bool
proc nk_input_has_mouse_click_in_button_rect*(input; btn: Button; rect): bool
proc nk_input_has_mouse_click_down_in_rect*(input; btn: Button; rect; down: bool): bool
proc nk_input_is_mouse_click_in_rect*(input; btn: Button; rect): bool
proc nk_input_is_mouse_click_down_in_rect*(input; btn: Button; rect; down: bool): bool
proc nk_input_any_mouse_click_in_rect*(input; rect): bool
proc nk_input_is_mouse_prev_hovering_rect*(input; rect): bool
proc nk_input_is_mouse_hovering_rect*(input; rect): bool
proc nk_input_mouse_clicked*(input; btn: Button; rect): bool
proc nk_input_is_mouse_down*(input; btn: Button): bool
proc nk_input_is_mouse_pressed*(input; btn: Button): bool
proc nk_input_is_mouse_released*(input; btn: Button): bool
proc nk_input_is_key_pressed*(input; key: KeyKind): bool
proc nk_input_is_key_released*(input; key: KeyKind): bool
proc nk_input_is_key_down*(input; key: KeyKind): bool
{.pop.}

#[ -------------------------------------------------------------------- ]#

using ctx: var Context

{.push inline.}

proc begin_input*(ctx) = nk_input_begin ctx.addr
proc end_input*(ctx)   = nk_input_end   ctx.addr
proc input_motion*(ctx; x: SomeNumber; y: SomeNumber) = nk_input_motion  ctx.addr, cint x, cint y
proc input_key*(ctx; key: KeyKind; down: bool)        = nk_input_key     ctx.addr, key, down
proc input_scroll*(ctx; x: SomeNumber; y: SomeNumber) = nk_input_scroll  ctx.addr, Vec2(x: cfloat x, y: cfloat y)
proc input_char*(ctx; c: char)                        = nk_input_char    ctx.addr, c
proc input_glyph*(ctx; c: Glyph)                      = nk_input_glyph   ctx.addr, c
proc input_unicode*(ctx; c: Rune)                     = nk_input_unicode ctx.addr, c
proc input_button*(ctx; btn: Button; x: SomeNumber; y: SomeNumber; down: bool) =
    nk_input_button ctx.addr, btn, cint x, cint y, down

proc is_mouse_pressed*(ctx; rect; btn = bLeft): bool = nk_input_mouse_clicked    ctx.input.addr, btn, rect
proc is_mouse_pressed*(ctx; btn = bLeft): bool       = nk_input_is_mouse_pressed ctx.input.addr, btn

proc is_mouse_hovering*(ctx; rect): bool  = nk_input_is_mouse_hovering_rect      ctx.input.addr, rect
proc was_mouse_hovering*(ctx; rect): bool = nk_input_is_mouse_prev_hovering_rect ctx.input.addr, rect

proc is_key_pressed*(ctx; key: KeyKind): bool = nk_input_is_key_pressed ctx.input.addr, key

{.pop.}
