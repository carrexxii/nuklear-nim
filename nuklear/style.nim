import common, font, text, drawing

const NkWidgetDisableFactor* = 0.5'f32

type
    StyleColours* {.size: sizeof(Flag).} = enum
        styleColourText
        styleColourWin
        styleColourHeader
        styleColourBorder
        styleColourBtn
        styleColourBtnHover
        styleColourBtnActive
        styleColourToggle
        styleColourToggleHover
        styleColourToggleCursor
        styleColourSelect
        styleColourSelectActive
        styleColourSlider
        styleColourSliderCursor
        styleColourSliderCursorHover
        styleColourSliderCursorActive
        styleColourProp
        styleColourEdit
        styleColourEditCursor
        styleColourCombo
        styleColourChart
        styleColourChartColour
        styleColourChartColourHighlight
        styleColourScrollbar
        styleColourScrollbarCursor
        styleColourScrollbarCursorHover
        styleColourScrollbarCursorActive
        styleColourTabHeader

    StyleCursor* {.size: sizeof(Flag).} = enum
        styleCursorArrow
        styleCursorText
        styleCursorMove
        styleCursorResizeVertical
        styleCursorResizeHorizontal
        styleCursorResizeTopLeftDownRight
        styleCursorResizeTopRightDownLeft

    StyleItemKind* {.size: sizeof(Flag).} = enum
        styleItemColour
        styleItemImage
        styleItemNineSlice

    StyleHeaderAlign* {.size: sizeof(Flag).} = enum
        styleHeaderLeft
        styleHeaderRight

type
    Style* = object
        font*          : UserFont
        cursors*       : array[1 + int StyleCursor.high, ptr Cursor]
        cursor_active* : ptr Cursor
        cursor_last*   : ptr Cursor
        cursor_visible*: cint

        text*          : StyleText
        btn*           : StyleButton
        contextual_btn*: StyleButton
        menu_btn*      : StyleButton
        option*        : StyleToggle
        checkbox*      : StyleToggle
        seleectable*   : StyleSelectable
        slider*        : StyleSlider
        progress*      : StyleProgress
        property*      : StyleProperty
        edit*          : StyleEdit
        chart*         : StyleChart
        scroll_h*      : StyleScrollbar
        scroll_v*      : StyleScrollbar
        tab*           : StyleTab
        combo*         : StyleCombo
        window*        : StyleWindow

    StyleItemData* {.union.} = object
        colour*: Colour
        img*   : Image
        slice* : NineSlice

    StyleItem* = object
        kind*: StyleItemKind
        data*: StyleItemData

    StyleText* = object
        colour*         : Colour
        padding*        : Vec2
        colour_factor*  : cfloat
        disabled_factor*: cfloat

    StyleButton* = object
        normal*          : StyleItem
        hover*           : StyleItem
        active*          : StyleItem
        border_colour*   : Colour
        colour_factor_bg*: cfloat

        text_bg*           : Colour
        text_normal*       : Colour
        text_hover*        : Colour
        text_active*       : Colour
        text_align*        : TextAlignment
        colour_factor_text*: cfloat

        border*         : cfloat
        rounding*       : cfloat
        padding*        : Vec2
        img_padding*    : Vec2
        touch_padding*  : Vec2
        disabled_factor*: cfloat

        user_data* : Handle
        draw_begin*: proc(buf: ptr CommandBuffer; user_data: Handle)
        draw_end*  : proc(buf: ptr CommandBuffer; user_data: Handle)

    StyleToggle* = object
        normal*       : StyleItem
        hover*        : StyleItem
        active*       : StyleItem
        border_colour*: Colour

        cursor_normal*: StyleItem
        cursor_hover* : StyleItem

        text_normal*: Colour
        text_hover* : Colour
        text_active*: Colour
        text_bg*    : Colour
        text_align* : TextAlignment

        padding*        : Vec2
        touch_padding*  : Vec2
        spacing*        : cfloat
        border*         : cfloat
        colour_factor*  : cfloat
        disabled_factor*: cfloat

        user_data* : Handle
        draw_begin*: proc(buf: ptr CommandBuffer; user_data: Handle)
        draw_end*  : proc(buf: ptr CommandBuffer; user_data: Handle)

    StyleSelectable* = object
        normal* : StyleItem
        hover*  : StyleItem
        pressed*: StyleItem

        normal_active* : StyleItem
        hover_active*  : StyleItem
        pressed_active*: StyleItem

        text_normal* : Colour
        text_hover*  : Colour
        text_pressed*: Colour

        text_normal_active* : Colour
        text_hover_active*  : Colour
        text_pressed_active*: Colour

        text_bg*   : Colour
        text_align*: TextAlignment

        rounding*       : cfloat
        padding*        : Vec2
        touch_padding*  : Vec2
        img_padding*    : Vec2
        colour_factor*  : cfloat
        disabled_factor*: cfloat

        user_data* : Handle
        draw_begin*: proc(buf: ptr CommandBuffer; user_data: Handle)
        draw_end*  : proc(buf: ptr CommandBuffer; user_data: Handle)

    StyleSlider* = object
        normal*       : StyleItem
        hover*        : StyleItem
        active*       : StyleItem
        border_colour*: Colour

        bar_normal*: Colour
        bar_hover* : Colour
        bar_active*: Colour
        bar_filled*: Colour

        cursor_normal*: StyleItem
        cursor_hover* : StyleItem
        cursor_active*: StyleItem

        border*         : cfloat
        rounding*       : cfloat
        bar_height*     : cfloat
        padding*        : Vec2
        spacing*        : Vec2
        cursor_sz*      : Vec2
        colour_factor*  : cfloat
        disabled_factor*: cfloat

        show_btns*: cint
        inc_btn*  : StyleButton
        dec_btn*  : StyleButton
        inc_sym*  : SymbolKind
        dec_sym*  : SymbolKind

        user_data* : Handle
        draw_begin*: proc(buf: ptr CommandBuffer; user_data: Handle)
        draw_end*  : proc(buf: ptr CommandBuffer; user_data: Handle)

    StyleProgress* = object
        normal*       : StyleItem
        hover*        : StyleItem
        active*       : StyleItem
        border_colour*: Colour

        cursor_normal*       : StyleItem
        cursor_hover*        : StyleItem
        cursor_active*       : StyleItem
        cursor_border_colour*: Colour

        rounding*       : cfloat
        border*         : cfloat
        cursor_border*  : cfloat
        cursor_rounding*: cfloat
        padding*        : Vec2
        colour_factor*  : cfloat
        disabled_factor*: cfloat

        user_data* : Handle
        draw_begin*: proc(buf: ptr CommandBuffer; user_data: Handle)
        draw_end*  : proc(buf: ptr CommandBuffer; user_data: Handle)

    StyleScrollbar* = object
        normal*       : StyleItem
        hover*        : StyleItem
        active*       : StyleItem
        border_colour*: Colour

        cursor_normal*       : StyleItem
        cursor_hover*        : StyleItem
        cursor_active*       : StyleItem
        cursor_border_colour*: Colour

        border*         : cfloat
        rounding*       : cfloat
        cursor_border*  : cfloat
        cursor_rounding*: cfloat
        padding*        : Vec2
        colour_factor*  : cfloat
        disabled_factor*: cfloat

        show_btns*: cint
        inc_btn*  : StyleButton
        dec_btn*  : StyleButton
        inc_sym*  : SymbolKind
        dec_sym*  : SymbolKind

        user_data* : Handle
        draw_begin*: proc(buf: ptr CommandBuffer; user_data: Handle)
        draw_end*  : proc(buf: ptr CommandBuffer; user_data: Handle)

    StyleEdit* = object
        normal*       : StyleItem
        hover*        : StyleItem
        active*       : StyleItem
        border_colour*: Colour
        scrollbar*    : StyleScrollbar

        cursor_normal*     : Colour
        cursor_hover*      : Colour
        cursor_text_normal*: Colour
        cursor_text_hover* : Colour

        text_normal*: Colour
        text_hover* : Colour
        text_active*: Colour

        selected_normal*     : Colour
        selected_hover*      : Colour
        selected_text_normal*: Colour
        selected_text_hover* : Colour

        border*         : cfloat
        rounding*       : cfloat
        cursor_sz*      : cfloat
        scrollbar_sz*   : Vec2
        padding*        : Vec2
        row_padding*    : Vec2
        colour_factor*  : cfloat
        disabled_factor*: cfloat

    StyleProperty* = object
        normal*       : StyleItem
        hover*        : StyleItem
        active*       : StyleItem
        border_colour*: Colour

        label_normal*: Colour
        label_hover* : Colour
        label_active*: Colour

        sym_left* : SymbolKind
        sym_right*: SymbolKind

        border*         : cfloat
        rounding*       : cfloat
        padding*        : Vec2
        colour_factor*  : cfloat
        disabled_factor*: cfloat

        edit*   : StyleEdit
        inc_btn*: StyleButton
        dec_btn*: StyleButton

        user_data* : Handle
        draw_begin*: proc(buf: ptr CommandBuffer; user_data: Handle)
        draw_end*  : proc(buf: ptr CommandBuffer; user_data: Handle)

    StyleChart* = object
        bg*             : StyleItem
        border_colour*  : Colour
        selected_colour*: Colour
        colour*         : Colour

        border*         : cfloat
        rounding*       : cfloat
        padding*        : Vec2
        colour_factor*  : cfloat
        disabled_factor*: cfloat
        show_markers*   : bool

    StyleCombo* = object
        normal*       : StyleItem
        hover*        : StyleItem
        active*       : StyleItem
        border_colour*: Colour

        label_normal*: Colour
        label_hover* : Colour
        label_active*: Colour

        sym_colour_normal*: Colour
        sym_colour_hover* : Colour
        sym_colour_active*: Colour

        btn*       : StyleButton
        sym_normal*: SymbolKind
        sym_hover* : SymbolKind
        sym_active*: SymbolKind

        border*         : cfloat
        rounding*       : cfloat
        content_padding*: Vec2
        btn_padding*    : Vec2
        spacing*        : Vec2
        colour_factor*  : cfloat
        disabled_factor*: cfloat

    StyleTab* = object
        bg*           : StyleItem
        border_colour*: Colour
        text*         : Colour

        tab_maximize_btn* : StyleButton
        tab_minimize_btn* : StyleButton
        node_maximize_btn*: StyleButton
        node_minimize_btn*: StyleButton
        sym_minimize*     : SymbolKind
        sym_maximize*     : SymbolKind

        border*         : cfloat
        rounding*       : cfloat
        indent*         : cfloat
        padding*        : Vec2
        spacing*        : Vec2
        colour_factor*  : cfloat
        disabled_factor*: cfloat

    StyleWindowHeader* = object
        normal*: StyleItem
        hover* : StyleItem
        active*: StyleItem

        close_btn*   : StyleButton
        minimize_btn*: StyleButton
        close_sym*   : SymbolKind
        minimize_sym*: SymbolKind
        maximize_sym*: SymbolKind

        label_normal*: Colour
        label_hover* : Colour
        label_active*: Colour

        align*        : StyleHeaderAlign
        padding*      : Vec2
        label_padding*: Vec2
        spacing*      : Vec2

    StyleWindow* = object
        header*  : StyleWindowHeader
        fixed_bg*: StyleItem
        bg*      : Colour

        border_colour*           : Colour
        popup_border_colour*     : Colour
        combo_border_colour*     : Colour
        contextual_border_colour*: Colour
        menu_border_colour*      : Colour
        group_border_colour*     : Colour
        tooltip_border_colour*   : Colour
        scaler*                  : StyleItem

        border*           : cfloat
        combo_border*     : cfloat
        contextual_border*: cfloat
        menu_border*      : cfloat
        group_border*     : cfloat
        tooltip_border*   : cfloat
        popup_border*     : cfloat
        min_row_h_padding*: cfloat

        rounding*    : cfloat
        spacing*     : Vec2
        scrollbar_sz*: Vec2
        min_sz*      : Vec2

        padding*           : Vec2
        group_padding*     : Vec2
        popup_padding*     : Vec2
        combo_padding*     : Vec2
        contextual_padding*: Vec2
        menu_padding*      : Vec2
        tooltip_padding*   : Vec2

# NK_API void nk_style_default(struct nk_context*);
# NK_API void nk_style_from_table(struct nk_context*, const struct nk_color*);
# NK_API void nk_style_load_cursor(struct nk_context*, enum nk_style_cursor, const struct nk_cursor*);
# NK_API void nk_style_load_all_cursors(struct nk_context*, struct nk_cursor*);
# NK_API const char* nk_style_get_color_by_name(enum nk_style_colors);
# NK_API void nk_style_set_font(struct nk_context*, const struct nk_user_font*);
# NK_API nk_bool nk_style_set_cursor(struct nk_context*, enum nk_style_cursor);
# NK_API void nk_style_show_cursor(struct nk_context*);
# NK_API void nk_style_hide_cursor(struct nk_context*);

# NK_API nk_bool nk_style_push_font(struct nk_context*, const struct nk_user_font*);
# NK_API nk_bool nk_style_push_float(struct nk_context*, float*, float);
# NK_API nk_bool nk_style_push_vec2(struct nk_context*, struct nk_vec2*, struct nk_vec2);
# NK_API nk_bool nk_style_push_style_item(struct nk_context*, struct nk_style_item*, struct nk_style_item);
# NK_API nk_bool nk_style_push_flags(struct nk_context*, nk_flags*, nk_flags);
# NK_API nk_bool nk_style_push_color(struct nk_context*, struct nk_color*, struct nk_color);

# NK_API nk_bool nk_style_pop_font(struct nk_context*);
# NK_API nk_bool nk_style_pop_float(struct nk_context*);
# NK_API nk_bool nk_style_pop_vec2(struct nk_context*);
# NK_API nk_bool nk_style_pop_style_item(struct nk_context*);
# NK_API nk_bool nk_style_pop_flags(struct nk_context*);
# NK_API nk_bool nk_style_pop_color(struct nk_context*);

# NK_API struct nk_style_item nk_style_item_color(struct nk_color);
# NK_API struct nk_style_item nk_style_item_image(struct nk_image img);
# NK_API struct nk_style_item nk_style_item_nine_slice(struct nk_nine_slice slice);
# NK_API struct nk_style_item nk_style_item_hide(void);
