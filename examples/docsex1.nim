# immediate-mode-ui.github.io/Nuklear/doc/#nuklear/example

import nuklear

type States = enum
    easy
    hard

let val = 0.6'f32
let i   = 20'i32
var op  = easy
var ctx: NkContext
# nk_init_fixed(&ctx, calloc(1, MAX_MEMORY), MAX_MEMORY, &font);
nk_init_fixed ctx.addr, alloc 10000, 10000, nil
# if (nk_begin(&ctx, "Show", nk_rect(50, 50, 220, 220), NK_WINDOW_BORDER|NK_WINDOW_MOVABLE|NK_WINDOW_CLOSABLE)) {
if nk_begin(ctx.addr, "Show", NkRect(x: 50, y: 50, w: 220, h: 200), nkWinBorder.ord or nkWinMovable.ord or nkWinClosable.ord):
#     nk_layout_row_static(&ctx, 30, 80, 1);
    nk_layout_row_static ctx.addr, 30, 80, 1
#     if (nk_button_label(&ctx, "button")) {
    if nk_button_label(ctx.addr, "button"):
        discard # event handling

#     nk_layout_row_dynamic(&ctx, 30, 2);
    nk_layout_row_dynamic ctx.addr, 30, 2
#     if (nk_option_label(&ctx, "easy", op == EASY)) op = EASY;
    if   nk_option_label(ctx.addr, "easy", op == easy): op = easy
#     if (nk_option_label(&ctx, "hard", op == HARD)) op = HARD;
    elif nk_option_label(ctx.addr, "hard", op == hard): op = hard

    nk_layout_row_begin ctx.addr, nkStatic, 30, 2   # nk_layout_row_begin(&ctx, NK_STATIC, 30, 2);
    nk_layout_row_push ctx.addr, 50                 # nk_layout_row_push(&ctx, 50);
    nk_label ctx.addr, "Volume: ", cast[NkTextAlignment](0x11) # nkTextLeft       # nk_label(&ctx, "Volume:", NK_TEXT_LEFT);
    nk_layout_row_push ctx.addr, 110                # nk_layout_row_push(&ctx, 110);
    nk_slider_float ctx.addr, 0, val.addr, 1.0, 0.1 # nk_slider_float(&ctx, 0, &value, 1.0f, 0.1f);
    nk_layout_row_end ctx.addr

nk_end ctx.addr
