import common

using
    ctx  : ptr Context
    input: ptr Input
    rect : Rect

proc nk_input_begin*(ctx)                                       {.importc: "nk_input_begin"  .}
proc nk_input_motion*(ctx; x, y: cint)                          {.importc: "nk_input_motion" .}
proc nk_input_key*(ctx; key: KeyKind; down: bool)               {.importc: "nk_input_key"    .}
proc nk_input_button*(ctx; btn: Button; x, y: cint; down: bool) {.importc: "nk_input_button" .}
proc nk_input_scroll*(ctx; val: Vec2)                           {.importc: "nk_input_scroll" .}
proc nk_input_char*(ctx; c: char)                               {.importc: "nk_input_char"   .}
proc nk_input_glyph*(ctx; c: Glyph)                             {.importc: "nk_input_glyph"  .}
proc nk_input_unicode*(ctx; c: Rune)                            {.importc: "nk_input_unicode".}
proc nk_input_end*(ctx)                                         {.importc: "nk_input_end"    .}

proc nk_input_has_mouse_click*(input; btn: Button): bool                                {.importc: "nk_input_has_mouse_click"               .}
proc nk_input_has_mouse_click_in_rect*(input; btn: Button; rect): bool                  {.importc: "nk_input_has_mouse_click_in_rect"       .}
proc nk_input_has_mouse_click_in_button_rect*(input; kind: Button; rect): bool          {.importc: "nk_input_has_mouse_click_in_button_rect".}
proc nk_input_has_mouse_click_down_in_rect*(input; btn: Button; rect; down: bool): bool {.importc: "nk_input_has_mouse_click_down_in_rect"  .}
proc nk_input_is_mouse_click_in_rect*(input; btn: Button; rect): bool                   {.importc: "nk_input_is_mouse_click_in_rect"        .}
proc nk_input_is_mouse_click_down_in_rect*(input; btn: Button; rect; down: bool): bool  {.importc: "nk_input_is_mouse_click_down_in_rect"   .}
proc nk_input_any_mouse_click_in_rect*(input; rect): bool                               {.importc: "nk_input_any_mouse_click_in_rect"       .}
proc nk_input_is_mouse_prev_hovering_rect*(input; rect): bool                           {.importc: "nk_input_is_mouse_prev_hovering_rect"   .}
proc nk_input_is_mouse_hovering_rect*(input; rect): bool                                {.importc: "nk_input_is_mouse_hovering_rect"        .}
proc nk_input_mouse_clicked*(input; btn: Button; rect): bool                            {.importc: "nk_input_mouse_clicked"                 .}
proc nk_input_is_mouse_down*(input; btn: Button): bool                                  {.importc: "nk_input_is_mouse_down"                 .}
proc nk_input_is_mouse_pressed*(input; btn: Button): bool                               {.importc: "nk_input_is_mouse_pressed"              .}
proc nk_input_is_mouse_released*(input; btn: Button): bool                              {.importc: "nk_input_is_mouse_released"             .}
proc nk_input_is_key_pressed*(input; key: KeyKind): bool                                {.importc: "nk_input_is_key_pressed"                .}
proc nk_input_is_key_released*(input; key: KeyKind): bool                               {.importc: "nk_input_is_key_released"               .}
proc nk_input_is_key_down*(input; key: KeyKind): bool                                   {.importc: "nk_input_is_key_down"                   .}

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

{.pop.}
