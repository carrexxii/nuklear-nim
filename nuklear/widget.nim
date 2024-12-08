import std/[macros, strutils], common

using
    ctx      : ptr Context
    text     : cstring
    label    : cstring
    sym      : SymbolKind
    img      : Image
    align    : TextAlignment
    bnt_style: ptr StyleButton

proc nk_widget*(rect: ptr Rect; ctx): WidgetLayoutState                    {.importc: "nk_widget"                     .}
proc nk_widget_fitting*(rect: ptr Rect; ctx; pos: Vec2): WidgetLayoutState {.importc: "nk_widget_fitting"             .}
proc nk_widget_bounds*(ctx): Rect                                          {.importc: "nk_widget_bounds"              .}
proc nk_widget_position*(ctx): Vec2                                        {.importc: "nk_widget_position"            .}
proc nk_widget_size*(ctx): Vec2                                            {.importc: "nk_widget_size"                .}
proc nk_widget_width*(ctx): cfloat                                         {.importc: "nk_widget_width"               .}
proc nk_widget_height*(ctx): cfloat                                        {.importc: "nk_widget_height"              .}
proc nk_widget_is_hovered*(ctx): bool                                      {.importc: "nk_widget_is_hovered"          .}
proc nk_widget_is_mouse_clicked*(ctx; btns: Button): bool                  {.importc: "nk_widget_is_mouse_clicked"    .}
proc nk_widget_has_mouse_click_down*(ctx; btns: Button; down: bool): bool  {.importc: "nk_widget_has_mouse_click_down".}

proc nk_spacing*(ctx; cols: cint)  {.importc: "nk_spacing"             .}
proc nk_widget_disable_begin*(ctx) {.importc: "nk_widget_disable_begin".}
proc nk_widget_disable_end*(ctx)   {.importc: "nk_widget_disable_end"  .}

proc nk_button_text*(ctx; text; len: cint): bool                                      {.importc: "nk_button_text"               .}
proc nk_button_label*(ctx; text): bool                                                {.importc: "nk_button_label"              .}
proc nk_button_colour*(ctx; colour: Colour): bool                                     {.importc: "nk_button_colour"             .}
proc nk_button_symbol*(ctx; sym): bool                                                {.importc: "nk_button_symbol"             .}
proc nk_button_image*(ctx; img): bool                                                 {.importc: "nk_button_image"              .}
proc nk_button_symbol_label*(ctx; sym; text; align): bool                             {.importc: "nk_button_symbol_label"       .}
proc nk_button_symbol_text*(ctx; sym; text; len: cint; align): bool                   {.importc: "nk_button_symbol_text"        .}
proc nk_button_image_label*(ctx; img; text; align): bool                              {.importc: "nk_button_image_label"        .}
proc nk_button_image_text*(ctx; img; text; len: cint; align): bool                    {.importc: "nk_button_image_text"         .}
proc nk_button_text_styled*(ctx; bnt_style; text; len: cint): bool                    {.importc: "nk_button_text_styled"        .}
proc nk_button_label_styled*(ctx; bnt_style; text): bool                              {.importc: "nk_button_label_styled"       .}
proc nk_button_symbol_styled*(ctx; bnt_style; sym): bool                              {.importc: "nk_button_symbol_styled"      .}
proc nk_button_image_styled*(ctx; bnt_style; img): bool                               {.importc: "nk_button_image_styled"       .}
proc nk_button_symbol_text_styled*(ctx; bnt_style; sym; text; len: cint; align): bool {.importc: "nk_button_symbol_text_styled" .}
proc nk_button_symbol_label_styled*(ctx; bnt_style; sym; text; align): bool           {.importc: "nk_button_symbol_label_styled".}
proc nk_button_image_label_styled*(ctx; bnt_style; img; text; align): bool            {.importc: "nk_button_image_label_styled" .}
proc nk_button_image_text_styled*(ctx; bnt_style; img; text; len: cint; align): bool  {.importc: "nk_button_image_text_styled"  .}
proc nk_button_set_behavior*(ctx; behaviour: ButtonBehaviour)                         {.importc: "nk_button_set_behavior"       .}
proc nk_button_push_behavior*(ctx; behaviour: ButtonBehaviour): bool                  {.importc: "nk_button_push_behavior"      .}
proc nk_button_pop_behavior*(ctx): bool                                               {.importc: "nk_button_pop_behavior"       .}

proc nk_option_label*(ctx; label; is_active: bool): bool                                                          {.importc: "nk_option_label"      .}
proc nk_option_label_align*(ctx; label; is_active: bool; widget_align, text_align: TextAlignment): bool           {.importc: "nk_option_label_align".}
proc nk_option_text*(ctx; text; len: cint; is_active: bool): bool                                                 {.importc: "nk_option_text"       .}
proc nk_option_text_align*(ctx; text; len: cint; is_active: bool; widget_align, text_align: TextAlignment): bool  {.importc: "nk_option_text_align" .}

proc nk_slider_float*(ctx; min: cfloat; val: ptr cfloat; max, step: cfloat): bool {.importc: "nk_slider_float".}

proc nk_menubar_begin*(ctx)                                                            {.importc: "nk_menubar_begin"          .}
proc nk_menubar_end*(ctx)                                                              {.importc: "nk_menubar_end"            .}
proc nk_menu_begin_text*(ctx; text; text_len: cint; align; sz: Vec2): bool             {.importc: "nk_menu_begin_text"        .}
proc nk_menu_begin_label*(ctx; text; align; sz: Vec2): bool                            {.importc: "nk_menu_begin_label"       .}
proc nk_menu_begin_image*(ctx; text; img; sz: Vec2): bool                              {.importc: "nk_menu_begin_image"       .}
proc nk_menu_begin_image_text*(ctx; text; text_len: cint; align; img; sz: Vec2): bool  {.importc: "nk_menu_begin_image_text"  .}
proc nk_menu_begin_image_label*(ctx; text; align; img; sz: Vec2): bool                 {.importc: "nk_menu_begin_image_label" .}
proc nk_menu_begin_symbol*(ctx; text; sym; sz: Vec2): bool                             {.importc: "nk_menu_begin_symbol"      .}
proc nk_menu_begin_symbol_text*(ctx; text; text_len: cint; align; sym; sz: Vec2): bool {.importc: "nk_menu_begin_symbol_text" .}
proc nk_menu_begin_symbol_label*(ctx; text; align; sym; sz: Vec2): bool                {.importc: "nk_menu_begin_symbol_label".}
proc nk_menu_item_text*(ctx; text; text_len: cint; align): bool                        {.importc: "nk_menu_item_text"         .}
proc nk_menu_item_label*(ctx; text; align): bool                                       {.importc: "nk_menu_item_label"        .}
proc nk_menu_item_image_label*(ctx; img; text; align): bool                            {.importc: "nk_menu_item_image_label"  .}
proc nk_menu_item_image_text*(ctx; img; text; text_len: cint; align): bool             {.importc: "nk_menu_item_image_text"   .}
proc nk_menu_item_symbol_text*(ctx; sym; text; text_len: cint; align): bool            {.importc: "nk_menu_item_symbol_text"  .}
proc nk_menu_item_symbol_label*(ctx; sym; text; align): bool                           {.importc: "nk_menu_item_symbol_label" .}
proc nk_menu_close*(ctx)                                                               {.importc: "nk_menu_close"             .}
proc nk_menu_end*(ctx)                                                                 {.importc: "nk_menu_end"               .}

#[ -------------------------------------------------------------------- ]#

using
    ctx : var Context
    text: string

{.push inline.}

proc slider*(ctx; val: ptr float32; min, max, step: float32): bool {.discardable.} =
    nk_slider_float(ctx.addr, cfloat min, val, cfloat max, cfloat step)

proc button*(ctx; text): bool                      = nk_button_text   ctx.addr, cstring text, cint text.len
proc button*(ctx; colour: Colour): bool            = nk_button_colour ctx.addr, colour
proc button*(ctx; sym): bool                       = nk_button_symbol ctx.addr, sym
proc button*(ctx; img): bool                       = nk_button_image  ctx.addr, img
proc button*(ctx; text; sym; align = taLeft): bool = nk_button_symbol_text ctx.addr, sym, cstring text, cint text.len, align
proc button*(ctx; text; img; align = taLeft): bool = nk_button_image_text  ctx.addr, img, cstring text, cint text.len, align

proc `behaviour=`*(ctx; behave: ButtonBehaviour) = nk_button_set_behavior ctx.addr, behave
proc push*(ctx; behave: ButtonBehaviour): bool {.discardable.} = nk_button_push_behavior ctx.addr, behave
proc pop_behaviour*(ctx): bool                 {.discardable.} = nk_button_pop_behavior  ctx.addr

proc option*(ctx; text; is_active: bool): bool =
    nk_option_text ctx.addr, cstring text, cint text.len, is_active
proc option*(ctx; text; is_active: bool; widget_align, text_align: TextAlignment): bool =
    nk_option_text_align ctx.addr, cstring text, cint text.len, is_active, widget_align, text_align

proc begin_menubar*(ctx) = nk_menubar_begin ctx.addr
proc end_menubar*(ctx)   = nk_menubar_end   ctx.addr

proc begin_menu*(ctx; text; sz: Vec2; align = taLeft): bool      = nk_menu_begin_text        ctx.addr, cstring text, cint text.len, align, sz
proc begin_menu*(ctx; text; img; sz: Vec2; align = taLeft): bool = nk_menu_begin_image_text  ctx.addr, cstring text, cint text.len, align, img, sz
proc begin_menu*(ctx; text; sym; sz: Vec2; align = taLeft): bool = nk_menu_begin_symbol_text ctx.addr, cstring text, cint text.len, align, sym, sz

proc menu_item*(ctx; text; align = taLeft): bool      = nk_menu_item_text        ctx.addr     , cstring text, cint text.len, align
proc menu_item*(ctx; text; img; align = taLeft): bool = nk_menu_item_image_text  ctx.addr, img, cstring text, cint text.len, align
proc menu_item*(ctx; text; sym; align = taLeft): bool = nk_menu_item_symbol_text ctx.addr, sym, cstring text, cint text.len, align

proc close_menu*(ctx) = nk_menu_close ctx.addr
proc end_menu*(ctx)   = nk_menu_end   ctx.addr

proc menu*(ctx; text: string; sz: (SomeNumber, SomeNumber); align = taLeft; items: varargs[string]): bool {.discardable.} =
    ctx.begin_menu text, Vec2(x: cfloat sz[0], y: cfloat sz[1]), align
    for item in items:
        ctx.menu_item item, align
    ctx.end_menu

# TODO: add button option
macro menubar*(ctx; h: SomeNumber; menu_sz: (SomeNumber, SomeNumber); menus: untyped): typed =
    result = new_nim_node nnkStmtList
    let menus_len = menus.len
    result.add quote do:
        `ctx`.begin_menubar()
        `ctx`.row `menus_len`, `h`

    let mw = menu_sz[0]
    let mh = menu_sz[1]
    for menu in menus:
        let name     = menu[0]
        let contents = menu[1]
        let menu_len = contents.len

        name.expect_kind nnkStrLit

        # Build the list of menu items first
        var items = new_nim_node nnkStmtList
        for item in contents:
            let text = item[0]
            if item.len == 2:
                let inner = item[1]
                items.add quote do:
                    if `ctx`.menu_item `text`:
                        `inner`
            elif item.len == 3:
                let extra = item[1] # Symbol/Image
                let inner = item[2]
                items.add quote do:
                    if `ctx`.menu_item(`text`, `extra`):
                        `inner`
            else:
                error "Menu item elements should be (string, <body>) or (string, Image/SymbolKind, <body>)", item

        result.add quote do:
            let sz = Vec2(x: cfloat `mw`, y: cfloat (`menu_len` + 1)*`mh`)
            if `ctx`.begin_menu(`name`, sz):
                `ctx`.row 1, `mh`
                `items`
                `ctx`.end_menu()

    result.add quote do:
        `ctx`.end_menubar()

{.pop.}

# NK_API float nk_slide_float(struct nk_context*, float min, float val, float max, float step);
# NK_API int nk_slide_int(struct nk_context*, int min, int val, int max, int step);
# NK_API nk_bool nk_slider_int(struct nk_context*, int min, int *val, int max, int step);

# Checkbox
# NK_API nk_bool nk_check_label(struct nk_context*, const char*, nk_bool active);
# NK_API nk_bool nk_check_text(struct nk_context*, const char*, int, nk_bool active);
# NK_API nk_bool nk_check_text_align(struct nk_context*, const char*, int, nk_bool active, nk_flags widget_alignment, nk_flags text_alignment);
# NK_API unsigned nk_check_flags_label(struct nk_context*, const char*, unsigned int flags, unsigned int value);
# NK_API unsigned nk_check_flags_text(struct nk_context*, const char*, int, unsigned int flags, unsigned int value);
# NK_API nk_bool nk_checkbox_label(struct nk_context*, const char*, nk_bool *active);
# NK_API nk_bool nk_checkbox_label_align(struct nk_context *ctx, const char *label, nk_bool *active, nk_flags widget_alignment, nk_flags text_alignment);
# NK_API nk_bool nk_checkbox_text(struct nk_context*, const char*, int, nk_bool *active);
# NK_API nk_bool nk_checkbox_text_align(struct nk_context *ctx, const char *text, int len, nk_bool *active, nk_flags widget_alignment, nk_flags text_alignment);
# NK_API nk_bool nk_checkbox_flags_label(struct nk_context*, const char*, unsigned int *flags, unsigned int value);
# NK_API nk_bool nk_checkbox_flags_text(struct nk_context*, const char*, int, unsigned int *flags, unsigned int value);

# Radio
# NK_API nk_bool nk_radio_label(struct nk_context*, const char*, nk_bool *active);
# NK_API nk_bool nk_radio_label_align(struct nk_context *ctx, const char *label, nk_bool *active, nk_flags widget_alignment, nk_flags text_alignment);
# NK_API nk_bool nk_radio_text(struct nk_context*, const char*, int, nk_bool *active);
# NK_API nk_bool nk_radio_text_align(struct nk_context *ctx, const char *text, int len, nk_bool *active, nk_flags widget_alignment, nk_flags text_alignment);

# Selectable
# NK_API nk_bool nk_selectable_label(struct nk_context*, const char*, nk_flags align, nk_bool *value);
# NK_API nk_bool nk_selectable_text(struct nk_context*, const char*, int, nk_flags align, nk_bool *value);
# NK_API nk_bool nk_selectable_image_label(struct nk_context*,struct nk_image,  const char*, nk_flags align, nk_bool *value);
# NK_API nk_bool nk_selectable_image_text(struct nk_context*,struct nk_image, const char*, int, nk_flags align, nk_bool *value);
# NK_API nk_bool nk_selectable_symbol_label(struct nk_context*,enum nk_symbol_type,  const char*, nk_flags align, nk_bool *value);
# NK_API nk_bool nk_selectable_symbol_text(struct nk_context*,enum nk_symbol_type, const char*, int, nk_flags align, nk_bool *value);

# NK_API nk_bool nk_select_label(struct nk_context*, const char*, nk_flags align, nk_bool value);
# NK_API nk_bool nk_select_text(struct nk_context*, const char*, int, nk_flags align, nk_bool value);
# NK_API nk_bool nk_select_image_label(struct nk_context*, struct nk_image,const char*, nk_flags align, nk_bool value);
# NK_API nk_bool nk_select_image_text(struct nk_context*, struct nk_image,const char*, int, nk_flags align, nk_bool value);
# NK_API nk_bool nk_select_symbol_label(struct nk_context*,enum nk_symbol_type,  const char*, nk_flags align, nk_bool value);
# NK_API nk_bool nk_select_symbol_text(struct nk_context*,enum nk_symbol_type, const char*, int, nk_flags align, nk_bool value);

# Progress Bar
# NK_API nk_bool nk_progress(struct nk_context*, nk_size *cur, nk_size max, nk_bool modifyable);
# NK_API nk_size nk_prog(struct nk_context*, nk_size cur, nk_size max, nk_bool modifyable);

# Colour Picker
# NK_API struct nk_colorf nk_color_picker(struct nk_context*, struct nk_colorf, enum nk_color_format);
# NK_API nk_bool nk_color_pick(struct nk_context*, struct nk_colorf*, enum nk_color_format);

# Chart
# NK_API nk_bool nk_chart_begin(struct nk_context*, enum nk_chart_type, int num, float min, float max);
# NK_API nk_bool nk_chart_begin_colored(struct nk_context*, enum nk_chart_type, struct nk_color, struct nk_color active, int num, float min, float max);
# NK_API void nk_chart_add_slot(struct nk_context *ctx, const enum nk_chart_type, int count, float min_value, float max_value);
# NK_API void nk_chart_add_slot_colored(struct nk_context *ctx, const enum nk_chart_type, struct nk_color, struct nk_color active, int count, float min_value, float max_value);
# NK_API nk_flags nk_chart_push(struct nk_context*, float);
# NK_API nk_flags nk_chart_push_slot(struct nk_context*, float, int);
# NK_API void nk_chart_end(struct nk_context*);
# NK_API void nk_plot(struct nk_context*, enum nk_chart_type, const float *values, int count, int offset);
# NK_API void nk_plot_function(struct nk_context*, enum nk_chart_type, void *userdata, float(*value_getter)(void* user, int index), int count, int offset);

# Widget
# NK_API nk_bool nk_popup_begin(struct nk_context*, enum nk_popup_type, const char*, nk_flags, struct nk_rect bounds);
# NK_API void nk_popup_close(struct nk_context*);
# NK_API void nk_popup_end(struct nk_context*);
# NK_API void nk_popup_get_scroll(struct nk_context*, nk_uint *offset_x, nk_uint *offset_y);
# NK_API void nk_popup_set_scroll(struct nk_context*, nk_uint offset_x, nk_uint offset_y);

# Combobox
# NK_API int nk_combo(struct nk_context*, const char **items, int count, int selected, int item_height, struct nk_vec2 size);
# NK_API int nk_combo_separator(struct nk_context*, const char *items_separated_by_separator, int separator, int selected, int count, int item_height, struct nk_vec2 size);
# NK_API int nk_combo_string(struct nk_context*, const char *items_separated_by_zeros, int selected, int count, int item_height, struct nk_vec2 size);
# NK_API int nk_combo_callback(struct nk_context*, void(*item_getter)(void*, int, const char**), void *userdata, int selected, int count, int item_height, struct nk_vec2 size);
# NK_API void nk_combobox(struct nk_context*, const char **items, int count, int *selected, int item_height, struct nk_vec2 size);
# NK_API void nk_combobox_string(struct nk_context*, const char *items_separated_by_zeros, int *selected, int count, int item_height, struct nk_vec2 size);
# NK_API void nk_combobox_separator(struct nk_context*, const char *items_separated_by_separator, int separator, int *selected, int count, int item_height, struct nk_vec2 size);
# NK_API void nk_combobox_callback(struct nk_context*, void(*item_getter)(void*, int, const char**), void*, int *selected, int count, int item_height, struct nk_vec2 size);

# Abstract Combobox
# NK_API nk_bool nk_combo_begin_text(struct nk_context*, const char *selected, int, struct nk_vec2 size);
# NK_API nk_bool nk_combo_begin_label(struct nk_context*, const char *selected, struct nk_vec2 size);
# NK_API nk_bool nk_combo_begin_color(struct nk_context*, struct nk_color color, struct nk_vec2 size);
# NK_API nk_bool nk_combo_begin_symbol(struct nk_context*,  enum nk_symbol_type,  struct nk_vec2 size);
# NK_API nk_bool nk_combo_begin_symbol_label(struct nk_context*, const char *selected, enum nk_symbol_type, struct nk_vec2 size);
# NK_API nk_bool nk_combo_begin_symbol_text(struct nk_context*, const char *selected, int, enum nk_symbol_type, struct nk_vec2 size);
# NK_API nk_bool nk_combo_begin_image(struct nk_context*, struct nk_image img,  struct nk_vec2 size);
# NK_API nk_bool nk_combo_begin_image_label(struct nk_context*, const char *selected, struct nk_image, struct nk_vec2 size);
# NK_API nk_bool nk_combo_begin_image_text(struct nk_context*,  const char *selected, int, struct nk_image, struct nk_vec2 size);
# NK_API nk_bool nk_combo_item_label(struct nk_context*, const char*, nk_flags alignment);
# NK_API nk_bool nk_combo_item_text(struct nk_context*, const char*,int, nk_flags alignment);
# NK_API nk_bool nk_combo_item_image_label(struct nk_context*, struct nk_image, const char*, nk_flags alignment);
# NK_API nk_bool nk_combo_item_image_text(struct nk_context*, struct nk_image, const char*, int,nk_flags alignment);
# NK_API nk_bool nk_combo_item_symbol_label(struct nk_context*, enum nk_symbol_type, const char*, nk_flags alignment);
# NK_API nk_bool nk_combo_item_symbol_text(struct nk_context*, enum nk_symbol_type, const char*, int, nk_flags alignment);
# NK_API void nk_combo_close(struct nk_context*);
# NK_API void nk_combo_end(struct nk_context*);

# Tooltip
# NK_API void nk_tooltip(struct nk_context*, const char*);
# #ifdef NK_INCLUDE_STANDARD_VARARGS
# NK_API void nk_tooltipf(struct nk_context*, NK_PRINTF_FORMAT_STRING const char*, ...) NK_PRINTF_VARARG_FUNC(2);
# NK_API void nk_tooltipfv(struct nk_context*, NK_PRINTF_FORMAT_STRING const char*, va_list) NK_PRINTF_VALIST_FUNC(2);
# #endif
# NK_API nk_bool nk_tooltip_begin(struct nk_context*, float width);
# NK_API void nk_tooltip_end(struct nk_context*);
