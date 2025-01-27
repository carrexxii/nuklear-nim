import std/[macros, strutils], common

using
    ctx      : ptr Context
    text     : cstring
    label    : cstring
    sym      : SymbolKind
    img      : Image
    align    : TextAlignment
    bnt_style: ptr StyleButton

{.push importc, cdecl.}
proc nk_widget*(rect: ptr Rect; ctx): WidgetLayoutState
proc nk_widget_fitting*(rect: ptr Rect; ctx; pos: Vec2): WidgetLayoutState
proc nk_widget_bounds*(ctx): Rect
proc nk_widget_position*(ctx): Vec2
proc nk_widget_size*(ctx): Vec2
proc nk_widget_width*(ctx): cfloat
proc nk_widget_height*(ctx): cfloat
proc nk_widget_is_hovered*(ctx): bool
proc nk_widget_is_mouse_clicked*(ctx; btns: Button): bool
proc nk_widget_has_mouse_click_down*(ctx; btns: Button; down: bool): bool

proc nk_spacing*(ctx; cols: cint)
proc nk_widget_disable_begin*(ctx)
proc nk_widget_disable_end*(ctx)

proc nk_button_text*(ctx; text; len: cint): bool
proc nk_button_label*(ctx; text): bool
proc nk_button_color*(ctx; colour: Colour): bool
proc nk_button_symbol*(ctx; sym): bool
proc nk_button_image*(ctx; img): bool
proc nk_button_symbol_label*(ctx; sym; text; align): bool
proc nk_button_symbol_text*(ctx; sym; text; len: cint; align): bool
proc nk_button_image_label*(ctx; img; text; align): bool
proc nk_button_image_text*(ctx; img; text; len: cint; align): bool
proc nk_button_text_styled*(ctx; bnt_style; text; len: cint): bool
proc nk_button_label_styled*(ctx; bnt_style; text): bool
proc nk_button_symbol_styled*(ctx; bnt_style; sym): bool
proc nk_button_image_styled*(ctx; bnt_style; img): bool
proc nk_button_symbol_text_styled*(ctx; bnt_style; sym; text; len: cint; align): bool
proc nk_button_symbol_label_styled*(ctx; bnt_style; sym; text; align): bool
proc nk_button_image_label_styled*(ctx; bnt_style; img; text; align): bool
proc nk_button_image_text_styled*(ctx; bnt_style; img; text; len: cint; align): bool
proc nk_button_set_behavior*(ctx; behaviour: ButtonBehaviour)
proc nk_button_push_behavior*(ctx; behaviour: ButtonBehaviour): bool
proc nk_button_pop_behavior*(ctx): bool

proc nk_option_label*(ctx; label; is_active: bool): bool
proc nk_option_label_align*(ctx; label; is_active: bool; widget_align, text_align: TextAlignment): bool
proc nk_option_text*(ctx; text; len: cint; is_active: bool): bool
proc nk_option_text_align*(ctx; text; len: cint; is_active: bool; widget_align, text_align: TextAlignment): bool

proc nk_slider_float*(ctx; min: cfloat; val: ptr cfloat; max, step: cfloat): bool
proc nk_slider_int*(ctx; min: cint; val: ptr cint; max, step: cint): bool
proc nk_slide_float*(ctx; min: cfloat; val: cfloat; max, step: cfloat): cfloat
proc nk_slide_int*(ctx; min: cint; val: cint; max, step: cint): cint

proc nk_menubar_begin*(ctx)
proc nk_menubar_end*(ctx)
proc nk_menu_begin_text*(ctx; text; text_len: cint; align; sz: Vec2): bool
proc nk_menu_begin_label*(ctx; text; align; sz: Vec2): bool
proc nk_menu_begin_image*(ctx; text; img; sz: Vec2): bool
proc nk_menu_begin_image_text*(ctx; text; text_len: cint; align; img; sz: Vec2): bool
proc nk_menu_begin_image_label*(ctx; text; align; img; sz: Vec2): bool
proc nk_menu_begin_symbol*(ctx; text; sym; sz: Vec2): bool
proc nk_menu_begin_symbol_text*(ctx; text; text_len: cint; align; sym; sz: Vec2): bool
proc nk_menu_begin_symbol_label*(ctx; text; align; sym; sz: Vec2): bool
proc nk_menu_item_text*(ctx; text; text_len: cint; align): bool
proc nk_menu_item_label*(ctx; text; align): bool
proc nk_menu_item_image_label*(ctx; img; text; align): bool
proc nk_menu_item_image_text*(ctx; img; text; text_len: cint; align): bool
proc nk_menu_item_symbol_text*(ctx; sym; text; text_len: cint; align): bool
proc nk_menu_item_symbol_label*(ctx; sym; text; align): bool
proc nk_menu_close*(ctx)
proc nk_menu_end*(ctx)

proc nk_check_label*(ctx; label; active: bool): bool
proc nk_check_text*(ctx; text; len: cint; active: bool): bool
proc nk_check_text_align*(ctx; text; len: cint; active: bool; widget_align: WidgetAlignment; text_align: TextAlignment): bool
proc nk_check_flags_label*(ctx; label; flags, val: cuint): cuint
proc nk_check_flags_text*(ctx; text; len: cint; flags, val: cuint): cuint
proc nk_checkbox_label*(ctx; label; active: ptr bool): bool
proc nk_checkbox_label_align*(ctx; label; active: ptr bool; widget_align: WidgetAlignment; text_align: TextAlignment): bool
proc nk_checkbox_text*(ctx; text; len: cint; active: ptr bool): bool
proc nk_checkbox_text_align*(ctx; text; len: cint; active: ptr bool; widget_align: WidgetAlignment; text_align: TextAlignment): bool
proc nk_checkbox_flags_label*(ctx; label; flags: ptr cuint; val: cuint): bool
proc nk_checkbox_flags_text*(ctx; text; len: cint; flags: ptr cuint; val: cuint): bool

proc nk_progress*(ctx; sz: ptr uint; max: uint; modifiable: bool): bool
proc nk_prog*(ctx; cur, max: uint; modifiable: bool): bool

proc nk_chart_begin*(ctx; kind: ChartKind; cnt: cint; min, max: cfloat): bool
proc nk_chart_begin_colored*(ctx; kind: ChartKind; colour, active: Colour; cnt: cint; min, max: cfloat): bool
proc nk_chart_add_slot*(ctx; kind: ChartKind; cnt: cint; min, max: cfloat)
proc nk_chart_add_slot_colored*(ctx; kind: ChartKind; colour, active: Colour; cnt: cint; min, max: cfloat)
proc nk_chart_push*(ctx; val: cfloat): ChartEvent
proc nk_chart_push_slot*(ctx; val: cfloat; slot: cint): ChartEvent
proc nk_chart_end*(ctx)
proc nk_plot*(ctx; kind: ChartKind; vals: ptr cfloat; cnt, offset: cint)
proc nk_plot_function*(ctx; kind: ChartKind; user_data: pointer; fn: (proc(user: pointer; idx: cint): cfloat); cnt, offset: cint)

proc nk_popup_begin*(ctx; kind: PopupKind; title: cstring; flags: PanelFlag; bounds: Rect): bool
proc nk_popup_close*(ctx)
proc nk_popup_end*(ctx)
proc nk_popup_get_scroll*(ctx; offset_x, offset_y: ptr cuint)
proc nk_popup_set_scroll*(ctx; offset_x, offset_y: cuint)

proc nk_selectable_label*(ctx; text; align; val: ptr bool): bool
proc nk_selectable_text*(ctx; text; len: cint; align; val: ptr bool): bool
proc nk_selectable_image_label*(ctx; img; text; align; val: ptr bool): bool
proc nk_selectable_image_text*(ctx; img; text; len: cint; align; val: ptr bool): bool
proc nk_selectable_symbol_label*(ctx; sym; text; align; val: ptr bool): bool
proc nk_selectable_symbol_text*(ctx; sym; text; len: cint; align; val: ptr bool): bool

proc nk_combo*(ctx; items: cStringArray; cnt, selected, item_h: cint; sz: Vec2): cint
proc nk_combo_separator*(ctx; items: cstring; sep, selected, cnt, item_h: cint; sz: Vec2): cint
proc nk_combo_string*(ctx; items: cstring; selected, cnt, item_h: cint; sz: Vec2): cint
proc nk_combo_callback*(ctx; fn: proc(_: pointer; _: cint; _: ptr cstring) {.cdecl.}; user_data: pointer; selected, cnt, item_h: cint; sz: Vec2): cint
proc nk_combobox*(ctx; items: cStringArray; cnt: cint; selected: ptr cint; item_h: cint; sz: Vec2)
proc nk_combobox_string*(ctx; items: cstring; selected: ptr cint; cnt, item_h: cint; sz: Vec2)
proc nk_combobox_separator*(ctx; items: cstring; sep: cint; selected: ptr cint; cnt, item_h: cint; sz: Vec2)
proc nk_combobox_callback*(ctx; fn: proc(_: pointer; _: cint; _: ptr cstring) {.cdecl.}; user_data: pointer; selected: ptr cint; cnt, item_h: cint; sz: Vec2)

proc nk_combo_begin_text*(ctx; selected: cstring; len: cint; sz: Vec2): bool
proc nk_combo_begin_label*(ctx; selected: cstring; sz: Vec2): bool
proc nk_combo_begin_color*(ctx; colour: Colour; sz: Vec2): bool
proc nk_combo_begin_symbol*(ctx; sym; sz: Vec2): bool
proc nk_combo_begin_symbol_label*(ctx; selected: cstring; sym; sz: Vec2): bool
proc nk_combo_begin_symbol_text*(ctx; selected: cstring; len: cint; sym; sz: Vec2): bool
proc nk_combo_begin_image*(ctx; img; sz: Vec2): bool
proc nk_combo_begin_image_label*(ctx; selected: cstring; img: Image; sz: Vec2): bool
proc nk_combo_begin_image_text*(ctx; selected: cstring; len: cint; img: Image; sz: Vec2): bool
proc nk_combo_item_label*(ctx; selected: cstring; align): bool
proc nk_combo_item_text*(ctx; selected: cstring; len: cint; align): bool
proc nk_combo_item_image_label*(ctx; img; selected: cstring; align): bool
proc nk_combo_item_image_text*(ctx; img; selected: cstring; len: cint; align): bool
proc nk_combo_item_symbol_label*(ctx; sym; selected: cstring; align): bool
proc nk_combo_item_symbol_text*(ctx; sym; selected: cstring; len: cint; align): bool
proc nk_combo_close*(ctx)
proc nk_combo_end*(ctx)

proc nk_color_picker*(ctx; colour: ColourF; fmt: ColourFormat): ColourF
proc nk_color_pick*(ctx; colour: ptr ColourF; fmt: ColourFormat): bool

proc nk_tooltip*(ctx; str: cstring)
when defined NkIncludeStandardVarargs:
    discard # TODO
    # NK_API void nk_tooltipf(struct nk_context*, NK_PRINTF_FORMAT_STRING const char*, ...) NK_PRINTF_VARARG_FUNC(2);
    # NK_API void nk_tooltipfv(struct nk_context*, NK_PRINTF_FORMAT_STRING const char*, va_list) NK_PRINTF_VALIST_FUNC(2);
proc nk_tooltip_begin*(ctx; w: cfloat): bool
proc nk_tooltip_end*(ctx)

proc nk_contextual_begin*(ctx; flags: PanelKindFlag; pos: Vec2; trigger_bounds: Rect): bool
proc nk_contextual_item_text*(ctx; text; len: cint; align): bool
proc nk_contextual_item_label*(ctx; text; align): bool
proc nk_contextual_item_image_label*(ctx; img; text; align): bool
proc nk_contextual_item_image_text*(ctx; img; text; len: cint; align): bool
proc nk_contextual_item_symbol_label*(ctx; sym; text; align): bool
proc nk_contextual_item_symbol_text*(ctx; sym; text; len: cint; align): bool
proc nk_contextual_close*(ctx)
proc nk_contextual_end*(ctx)
{.pop.}

#[ -------------------------------------------------------------------- ]#

using
    ctx : var Context
    text: string

{.push inline.}

converter array_to_vec2*(t: array[2, float32]): Vec2      = Vec2(x: cfloat t[0], y: cfloat t[1])
converter array_to_colour*(t: array[4, uint8]): Colour    = Colour(r: uint8 t[0], g: uint8 t[1], b: uint8 t[2], a: uint8 t[3])
converter array_to_colour*(t: array[4, float32]): ColourF = ColourF(r: cfloat t[0], g: cfloat t[1], b: cfloat t[2], a: cfloat t[3])
converter array_to_rect*(t: array[4, float32]): Rect      = Rect(x: cfloat t[0], y: cfloat t[1], w: cfloat t[2], h: cfloat t[3])

proc widget_fitting*(ctx; rect: Rect; pos: Vec2): WidgetLayoutState =
    nk_widget_fitting rect.addr, ctx.addr, pos
proc widget_bounds*(ctx): Rect    = nk_widget_bounds ctx.addr
proc widget_pos*(ctx): Vec2       = nk_widget_position ctx.addr
proc widget_size*(ctx): Vec2      = nk_widget_size ctx.addr
proc widget_width*(ctx): float32  = float32 nk_widget_width ctx.addr
proc widget_height*(ctx): float32 = float32 nk_widget_height ctx.addr
proc widget_is_hovered*(ctx): bool                     = nk_widget_is_hovered ctx.addr
proc widget_is_mouse_clicked*(ctx; btns: Button): bool = nk_widget_is_mouse_clicked ctx.addr, btns
proc widget_has_mouse_click_down*(ctx; btns: Button; down: bool): bool =
    nk_widget_has_mouse_click_down ctx.addr, btns, down

proc slider*[T: SomeFloat](ctx; val: var T; range: Slice[SomeFloat]; step = 1'f32): bool {.discardable.} =
    var v = cfloat val
    result = nk_slider_float(ctx.addr, cfloat range.a, v.addr, cfloat range.b, cfloat step)
    val = T v
proc slider*[T: SomeInteger](ctx; val: var T; range: Slice[SomeInteger]; step = 1'i32): bool {.discardable.} =
    var v = cint val
    result = nk_slider_int(ctx.addr, cint range.a, v.addr, cint range.b, cint step)
    val = T v

proc progress_bar*(ctx; sz: var uint; max: uint; modifiable = false): bool {.discardable.} =
    nk_progress ctx.addr, sz.addr, max, modifiable

# TODO: flags checkbox
proc checkbox*(ctx; label: string; active: var bool; widget_align = waLeft; text_align = taLeft) =
    active = nk_check_text_align(ctx.addr, cstring label, cint label.len, active, widget_align, text_align)
proc checkbox*(ctx; label: string; active: bool; widget_align = waLeft; text_align = taLeft): bool =
    nk_check_text_align(ctx.addr, cstring label, cint label.len, active, widget_align, text_align)

proc selectable*(ctx; text; val: var bool; align = taLeft): bool {.discardable.} =
    nk_selectable_text ctx.addr, cstring text, cint text.len, align, val.addr
proc selectable*(ctx; text; img; val: var bool; align = taLeft): bool {.discardable.} =
    nk_selectable_image_text ctx.addr, img, cstring text, cint text.len, align, val.addr
proc selectable*(ctx; text; sym; val: var bool; align = taLeft): bool {.discardable.} =
    nk_selectable_symbol_text ctx.addr, sym, cstring text, cint text.len, align, val.addr

const DefaultPopupFlags = pfClosable or pfClosable or pfTitle
proc start_popup*(ctx; kind: PopupKind; title: string; bounds: Rect; flags = DefaultPopupFlags): bool =
    nk_popup_begin ctx.addr, kind, cstring title, flags, bounds
proc stop_popup*(ctx)  = nk_popup_end   ctx.addr
proc close_popup*(ctx) = nk_popup_close ctx.addr

proc popup_scroll*(ctx): tuple[x, y: uint32] =
    var x, y = cuint 0
    nk_popup_get_scroll ctx.addr, x.addr, y.addr
    (uint32 x, uint32 y)
proc `popupscroll=`*(ctx; offset: tuple[x, y: uint32]) =
    nk_popup_set_scroll ctx.addr, cuint offset.x, cuint offset.y

proc combobox*(ctx; items: string; sep: char; cnt, selected, item_h: int32; sz: array[2, float32]): int32 =
    ## Items separated with `sep`
    int32 nk_combo_separator(ctx.addr, cstring items, cint sep, cint selected, cint cnt, cint item_h, sz)
proc combobox*(ctx; items: cStringArray; cnt, selected, item_h: int32; sz: array[2, float32]): int32 =
    int32 nk_combo(ctx.addr, items, cint cnt, cint selected, cint item_h, sz)
proc combobox*(ctx; items: string; cnt, selected, item_h: int32; sz: array[2, float32]): int32 =
    ## Items separated by `\0`
    int32 nk_combo_string(ctx.addr, cstring items, cint cnt, cint selected, cint item_h, sz)

proc combobox*(ctx; items: string; sep: char; cnt: int32; selected: var int32; item_h: int32; sz: array[2, float32]) =
    ## Items separated with `sep`
    nk_combobox_separator ctx.addr, cstring items, cint sep, selected.addr, cint cnt, cint item_h, sz
proc combobox*(ctx; items: cStringArray; cnt: int32; selected: var int32; item_h: int32; sz: array[2, float32]) =
    nk_combobox ctx.addr, items, cint cnt, selected.addr, cint item_h, sz
proc combobox*(ctx; items: string; cnt: int32; selected: var int32; item_h: int32; sz: array[2, float32]) =
    ## Items separated by `\0`
    nk_combobox_string ctx.addr, cstring items, selected.addr, cint cnt, cint item_h, sz

proc start_combobox*(ctx; selected: string; sz: array[2, float32]): bool =
    nk_combo_begin_text ctx.addr, cstring selected, cint selected.len, sz
proc start_combobox*(ctx; colour: array[4, uint8]; sz: array[2, float32]): bool =
    nk_combo_begin_color ctx.addr, colour, sz
proc start_combobox*(ctx; selected: string; sym; sz: array[2, float32]): bool =
    nk_combo_begin_symbol_text ctx.addr, cstring selected, cint selected.len, sym, sz
proc start_combobox*(ctx; selected: string; img; sz: array[2, float32]): bool =
    nk_combo_begin_image_text ctx.addr, cstring selected, cint selected.len, img, sz

proc combo_item*(ctx; selected: string; align = taLeft): bool =
    nk_combo_item_text ctx.addr, cstring selected, cint selected.len, align
proc combo_item*(ctx; selected: string; sym; align = taLeft): bool =
    nk_combo_item_symbol_text ctx.addr, sym, cstring selected, cint selected.len, align
proc combo_item*(ctx; selected: string; img; align = taLeft): bool =
    nk_combo_item_image_text ctx.addr, img, cstring selected, cint selected.len, align

proc close_combobox*(ctx) = nk_combo_close ctx.addr
proc stop_combobox*(ctx)  = nk_combo_end   ctx.addr

proc colour_picker*(ctx; colour: array[4, float32]; fmt = cfRgba): array[4, float32] =
    let res = nk_color_picker(ctx.addr, colour, fmt)
    [res.r, res.g, res.b, res.a]
proc colour_picker*(ctx; colour: var array[4, float32]; fmt = cfRgba): bool =
    result = nk_color_pick(ctx.addr, cast[ptr ColourF](colour.addr), fmt)

proc tooltip*(ctx; str: string)            = nk_tooltip       ctx.addr, cstring str
proc start_tooltip*(ctx; w: float32): bool = nk_tooltip_begin ctx.addr, cfloat w
proc stop_tooltip*(ctx)                    = nk_tooltip_end   ctx.addr

proc start_contextual*(ctx; pos: Vec2; trigger_bounds: Rect; flags = pkfNone): bool =
    nk_contextual_begin ctx.addr, flags, pos, trigger_bounds
proc contextual_item*(ctx; text: string; align = taLeft): bool {.discardable.} =
    nk_contextual_item_text ctx.addr, text, cint text.len, align
proc contextual_item*(ctx; text: string; sym; align = taLeft): bool {.discardable.} =
    nk_contextual_item_symbol_text ctx.addr, sym, text, cint text.len, align
proc contextual_item*(ctx; text: string; img; align = taLeft): bool {.discardable.} =
    nk_contextual_item_image_text ctx.addr, img, text, cint text.len, align
proc close_contextual*(ctx) = nk_contextual_close ctx.addr
proc stop_contextual*(ctx)  = nk_contextual_end ctx.addr

proc button*(ctx; text): bool                      = nk_button_text   ctx.addr, cstring text, cint text.len
proc button*(ctx; colour: Colour): bool            = nk_button_color  ctx.addr, colour
proc button*(ctx; sym): bool                       = nk_button_symbol ctx.addr, sym
proc button*(ctx; img): bool                       = nk_button_image  ctx.addr, img
proc button*(ctx; text; sym; align = taLeft): bool = nk_button_symbol_text ctx.addr, sym, cstring text, cint text.len, align
proc button*(ctx; text; img; align = taLeft): bool = nk_button_image_text  ctx.addr, img, cstring text, cint text.len, align
proc button*(ctx; r, g, b: uint8; a = 255'u8): bool {.deprecated.} =
    let colour = Colour(r: r, g: g, b: b, a: a)
    nk_button_color ctx.addr, colour

proc `button_behaviour=`*(ctx; behave: ButtonBehaviour) = nk_button_set_behavior ctx.addr, behave
proc push*(ctx; behave: ButtonBehaviour): bool {.discardable.} = nk_button_push_behavior ctx.addr, behave
proc pop_behaviour*(ctx): bool                 {.discardable.} = nk_button_pop_behavior  ctx.addr

proc option*(ctx; text; is_active: bool): bool =
    nk_option_text ctx.addr, cstring text, cint text.len, is_active
proc option*(ctx; text; is_active: bool; widget_align, text_align: TextAlignment): bool =
    nk_option_text_align ctx.addr, cstring text, cint text.len, is_active, widget_align, text_align

proc start_menubar*(ctx) = nk_menubar_begin ctx.addr
proc stop_menubar*(ctx)  = nk_menubar_end   ctx.addr

proc start_menu*(ctx; text; sz: array[2, float32]; align = taLeft): bool =
    nk_menu_begin_text ctx.addr, cstring text, cint text.len, align, sz
proc start_menu*(ctx; text; img; sz: array[2, float32]; align = taLeft): bool =
    nk_menu_begin_image_text ctx.addr, cstring text, cint text.len, align, img, sz
proc start_menu*(ctx; text; sym; sz: array[2, float32]; align = taLeft): bool =
    nk_menu_begin_symbol_text ctx.addr, cstring text, cint text.len, align, sym, sz

proc menu_item*(ctx; text; align = taLeft): bool      = nk_menu_item_text        ctx.addr     , cstring text, cint text.len, align
proc menu_item*(ctx; text; img; align = taLeft): bool = nk_menu_item_image_text  ctx.addr, img, cstring text, cint text.len, align
proc menu_item*(ctx; text; sym; align = taLeft): bool = nk_menu_item_symbol_text ctx.addr, sym, cstring text, cint text.len, align

proc close_menu*(ctx) = nk_menu_close ctx.addr
proc stop_menu*(ctx)  = nk_menu_end   ctx.addr

proc menu*(ctx; text: string; sz: array[2, float32]; align = taLeft; items: varargs[string]): bool {.discardable.} =
    result = ctx.start_menu(text, sz, align)
    if result:
        for item in items:
            discard ctx.menu_item(item, align) # TODO
        stop_menu ctx

proc start_chart*(ctx; kind: ChartKind; cnt: int32; range: Slice[SomeFloat]): bool =
    nk_chart_begin ctx.addr, kind, cint cnt, cfloat range.a, cfloat range.b
proc start_chart*(ctx; kind: ChartKind; cnt: int32; range: Slice[SomeFloat]; colour, active: array[4, uint8]): bool =
    nk_chart_begin_colored ctx.addr, kind, colour, active, cint cnt, cfloat range.a, cfloat range.b
proc add_slot*(ctx; kind: ChartKind; cnt: int32; range: Slice[SomeFloat]) =
    nk_chart_add_slot ctx.addr, kind, cint cnt, cfloat range.a, cfloat range.b
proc add_slot*(ctx; kind: ChartKind; cnt: int32; range: Slice[SomeFloat]; colour, active: array[4, uint8]) =
    nk_chart_add_slot_colored ctx.addr, kind, colour, active, cint cnt, cfloat range.a, cfloat range.b
proc push_chart*(ctx; val: float32): ChartEvent {.discardable.}             = nk_chart_push ctx.addr, cfloat val
proc push_slot*(ctx; slot: int32; val: float32): ChartEvent {.discardable.} = nk_chart_push_slot ctx.addr, cfloat val, cint slot
proc stop_chart*(ctx) = nk_chart_end ctx.addr

proc plot*(ctx; kind: ChartKind; vals: openArray[float32]; offset = 0'i32) =
    nk_plot ctx.addr, kind, vals[0].addr, cint vals.len, cint offset
proc plot*(ctx; kind: ChartKind; cnt, offset: int32; fn: proc(user_data: pointer; idx: cint): cfloat; user_data: pointer = nil) =
    nk_plot_function ctx.addr, kind, user_data, fn, cint cnt, cint offset

{.pop.}

# TODO: automatic size calculations
macro menubar*(ctx; h: float32; menu_sz: array[2, float32]; menus: untyped): untyped =
    ## ctx.menubar 35, (80, 30):
    ##     "File":
    ##         "Open":
    ##             open_file()
    ##         "Quit" skX:
    ##             quit 0
    ##     "Help":
    ##         "Help":
    ##             open_help()
    ##         "About":
    ##             about_popup()
    result = new_nim_node nnkStmtList
    template error(node: NimNode) =
        error "\nMenu item elements should be\n\t\"name\":\n\t\t<contents>\n" &
              "or\n\t\"name\" <img/sym>:\n\t\t<contents>\ngot:\n" & repr node

    let menu_count = menus.len
    let mw = menu_sz[0]
    let mh = menu_sz[1]
    result.add quote do:
        `ctx`.start_menubar()
        `ctx`.row `menu_count`, `h`, `mw`*`menu_count`

    for menu in menus:
        let name     = menu[0]
        let contents = menu[^1]
        let menu_len = menu.len

        name.expect_kind nnkStrLit

        var items = new_nim_node nnkStmtList
        # Button menu item
        if contents.len == 1 and contents[0].kind != nnkStrLit:
            let text  = menu[0]
            let inner = contents[0]
            result.add quote do:
                if `ctx`.button `text`:
                    `inner`
        # Menu list
        else:
            for item in contents:
                let text  = item[0]
                let inner = item[^1]
                if item.len == 2:
                    items.add quote do:
                        if `ctx`.menu_item `text`:
                            `inner`
                elif item.len == 3:
                    let img_or_sym = menu[1]
                    items.add quote do:
                        if `ctx`.menu_item(`text`, `img_or_sym`):
                            `inner`
                else:
                    error item

            if menu_len == 2:
                result.add quote do:
                    let sz = Vec2(x: 2*cfloat `mw`, y: cfloat 2*`menu_len`*`mh`)
                    if `ctx`.begin_menu(`name`, sz):
                        `ctx`.row 1, `mh`
                        `items`
                        `ctx`.stop_menu()
            elif menu_len == 3:
                let img_or_sym = menu[1]
                result.add quote do:
                    let sz = Vec2(x: 2*cfloat `mw`, y: cfloat 2*`menu_len`*`mh`)
                    if `ctx`.start_menu(`name`, `img_or_sym`, sz):
                        `ctx`.row 1, `mh`
                        `items`
                        `ctx`.stop_menu()
            else:
                error menu

    result.add quote do:
        `ctx`.stop_menubar()

# Radio
# NK_API nk_bool nk_radio_label(struct nk_context*, const char*, nk_bool *active);
# NK_API nk_bool nk_radio_label_align(struct nk_context *ctx, const char *label, nk_bool *active, nk_flags widget_alignment, nk_flags text_alignment);
# NK_API nk_bool nk_radio_text(struct nk_context*, const char*, int, nk_bool *active);
# NK_API nk_bool nk_radio_text_align(struct nk_context *ctx, const char *text, int len, nk_bool *active, nk_flags widget_alignment, nk_flags text_alignment);

# NK_API nk_bool nk_select_label(struct nk_context*, const char*, nk_flags align, nk_bool value);
# NK_API nk_bool nk_select_text(struct nk_context*, const char*, int, nk_flags align, nk_bool value);
# NK_API nk_bool nk_select_image_label(struct nk_context*, struct nk_image,const char*, nk_flags align, nk_bool value);
# NK_API nk_bool nk_select_image_text(struct nk_context*, struct nk_image,const char*, int, nk_flags align, nk_bool value);
# NK_API nk_bool nk_select_symbol_label(struct nk_context*,enum nk_symbol_type,  const char*, nk_flags align, nk_bool value);
# NK_API nk_bool nk_select_symbol_text(struct nk_context*,enum nk_symbol_type, const char*, int, nk_flags align, nk_bool value);
