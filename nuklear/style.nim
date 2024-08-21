import common, font, text, drawing

const NkWidgetDisableFactor* = 0.5'f32

{.push size: sizeof(NkFlag).}
type
    NkStylColours* = enum
        nkColourText
        nkColourWindow
        nkColourHeader
        nkColourBorder
        nkColourButton
        nkColourButtonHover
        nkColourButtonActive
        nkColourToggle
        nkColourToggleHover
        nkColourToggleCursor
        nkColourSelect
        nkColourSelectActive
        nkColourSlider
        nkColourSliderCursor
        nkColourSliderCursorHover
        nkColourSliderCursorActive
        nkColourProperty
        nkColourEdit
        nkColourEditCursor
        nkColourCombo
        nkColourChart
        nkColourChartColour
        nkColourChartColourHighlight
        nkColourScrollbar
        nkColourScrollbarCursor
        nkColourScrollbarCursorHover
        nkColourScrollbarCursorActive
        nkColourTabHeader

    NkStyleCursor* = enum
        nkCursorArrow
        nkCursorText
        nkCursorMove
        nkCursorResizeVertical
        nkCursorResizeHorizontal
        nkCursorResizeTopLeftDownRight
        nkCursorResizeTopRightDownLeft

    NkStyleItemKind* = enum
        nkStyleItemColour
        nkStyleItemImage
        nkStyleItemNineSlice

    NkStyleHeaderAlign* = enum
        nkHeaderLeft
        nkHeaderRight
{.pop.} # size: sizeof(NkFlag)

type
    NkStyle* = object
        font*          : NkUserFont
        cursors*       : array[1 + int NkStyleCursor.high, ptr NkCursor]
        cursor_active* : ptr NkCursor
        cursor_last*   : ptr NkCursor
        cursor_visible*: int32

        text*          : NkStyleText
        btn*           : NkStyleButton
        contextual_btn*: NkStyleButton
        menu_btn*      : NkStyleButton
        option*        : NkStyleToggle
        checkbox*      : NkStyleToggle
        seleectable*   : NkStyleSelectable
        slider*        : NkStyleSlider
        progress*      : NkStyleProgress
        property*      : NkStyleProperty
        edit*          : NkStyleEdit
        chart*         : NkStyleChart
        scroll_h*      : NkStyleScrollbar
        scroll_v*      : NkStyleScrollbar
        tab*           : NkStyleTab
        combo*         : NkStyleCombo
        window*        : NkStyleWindow

    NkStyleItemData* {.union.} = object
        colour*: NkColour
        img*   : NkImage
        slice* : NkNineSlice

    NkStyleItem* = object
        kind*: NkStyleItemKind
        data*: NkStyleItemData

    NkStyleText* = object
        colour*         : NkColour
        padding*        : NkVec2
        colour_factor*  : float32
        disabled_factor*: float32

    NkStyleButton* = object
        normal*          : NkStyleItem
        hover*           : NkStyleItem
        active*          : NkStyleItem
        border_colour*   : NkColour
        colour_factor_bg*: float32

        text_bg*           : NkColour
        text_normal*       : NkColour
        text_hover*        : NkColour
        text_active*       : NkColour
        text_align*        : NkTextAlignment
        colour_factor_text*: float32

        border*         : float32
        rounding*       : float32
        padding*        : NkVec2
        img_padding*    : NkVec2
        touch_padding*  : NkVec2
        disabled_factor*: float32

        user_data* : NkHandle
        draw_begin*: proc(buf: ptr NkCommandBuffer; user_data: NkHandle)
        draw_end*  : proc(buf: ptr NkCommandBuffer; user_data: NkHandle)

    NkStyleToggle* = object
        normal*       : NkStyleItem
        hover*        : NkStyleItem
        active*       : NkStyleItem
        border_colour*: NkColour

        cursor_normal*: NkStyleItem
        cursor_hover* : NkStyleItem

        text_normal*: NkColour
        text_hover* : NkColour
        text_active*: NkColour
        text_bg*    : NkColour
        text_align* : NkTextAlignment

        padding*        : NkVec2
        touch_padding*  : NkVec2
        spacing*        : float32
        border*         : float32
        colour_factor*  : float32
        disabled_factor*: float32

        user_data* : NkHandle
        draw_begin*: proc(buf: ptr NkCommandBuffer; user_data: NkHandle)
        draw_end*  : proc(buf: ptr NkCommandBuffer; user_data: NkHandle)

    NkStyleSelectable* = object
        normal* : NkStyleItem
        hover*  : NkStyleItem
        pressed*: NkStyleItem

        normal_active* : NkStyleItem
        hover_active*  : NkStyleItem
        pressed_active*: NkStyleItem

        text_normal* : NkColour
        text_hover*  : NkColour
        text_pressed*: NkColour

        text_normal_active* : NkColour
        text_hover_active*  : NkColour
        text_pressed_active*: NkColour

        text_bg*   : NkColour
        text_align*: NkTextAlignment

        rounding*       : float32
        padding*        : NkVec2
        touch_padding*  : NkVec2
        img_padding*    : NkVec2
        colour_factor*  : float32
        disabled_factor*: float32

        user_data* : NkHandle
        draw_begin*: proc(buf: ptr NkCommandBuffer; user_data: NkHandle)
        draw_end*  : proc(buf: ptr NkCommandBuffer; user_data: NkHandle)

    NkStyleSlider* = object
        normal*       : NkStyleItem
        hover*        : NkStyleItem
        active*       : NkStyleItem
        border_colour*: NkColour

        bar_normal*: NkColour
        bar_hover* : NkColour
        bar_active*: NkColour
        bar_filled*: NkColour

        cursor_normal*: NkStyleItem
        cursor_hover* : NkStyleItem
        cursor_active*: NkStyleItem

        border*         : float32
        rounding*       : float32
        bar_height*     : float32
        padding*        : NkVec2
        spacing*        : NkVec2
        cursor_sz*      : NkVec2
        colour_factor*  : float32
        disabled_factor*: float32

        show_btns*: int32
        inc_btn*  : NkStyleButton
        dec_btn*  : NkStyleButton
        inc_sym*  : NkSymbolKind
        dec_sym*  : NkSymbolKind

        user_data* : NkHandle
        draw_begin*: proc(buf: ptr NkCommandBuffer; user_data: NkHandle)
        draw_end*  : proc(buf: ptr NkCommandBuffer; user_data: NkHandle)

    NkStyleProgress* = object
        normal*       : NkStyleItem
        hover*        : NkStyleItem
        active*       : NkStyleItem
        border_colour*: NkColour

        cursor_normal*       : NkStyleItem
        cursor_hover*        : NkStyleItem
        cursor_active*       : NkStyleItem
        cursor_border_colour*: NkColour

        rounding*       : float32
        border*         : float32
        cursor_border*  : float32
        cursor_rounding*: float32
        padding*        : NkVec2
        colour_factor*  : float32
        disabled_factor*: float32

        user_data* : NkHandle
        draw_begin*: proc(buf: ptr NkCommandBuffer; user_data: NkHandle)
        draw_end*  : proc(buf: ptr NkCommandBuffer; user_data: NkHandle)

    NkStyleScrollbar* = object
        normal*       : NkStyleItem
        hover*        : NkStyleItem
        active*       : NkStyleItem
        border_colour*: NkColour

        cursor_normal*       : NkStyleItem
        cursor_hover*        : NkStyleItem
        cursor_active*       : NkStyleItem
        cursor_border_colour*: NkColour

        border*         : float32
        rounding*       : float32
        cursor_border*  : float32
        cursor_rounding*: float32
        padding*        : NkVec2
        colour_factor*  : float32
        disabled_factor*: float32

        show_btns*: int32
        inc_btn*  : NkStyleButton
        dec_btn*  : NkStyleButton
        inc_sym*  : NkSymbolKind
        dec_sym*  : NkSymbolKind

        user_data* : NkHandle
        draw_begin*: proc(buf: ptr NkCommandBuffer; user_data: NkHandle)
        draw_end*  : proc(buf: ptr NkCommandBuffer; user_data: NkHandle)

    NkStyleEdit* = object
        normal*       : NkStyleItem
        hover*        : NkStyleItem
        active*       : NkStyleItem
        border_colour*: NkColour
        scrollbar*    : NkStyleScrollbar

        cursor_normal*     : NkColour
        cursor_hover*      : NkColour
        cursor_text_normal*: NkColour
        cursor_text_hover* : NkColour

        text_normal*: NkColour
        text_hover* : NkColour
        text_active*: NkColour

        selected_normal*     : NkColour
        selected_hover*      : NkColour
        selected_text_normal*: NkColour
        selected_text_hover* : NkColour

        border*         : float32
        rounding*       : float32
        cursor_sz*      : float32
        scrollbar_sz*   : NkVec2
        padding*        : NkVec2
        row_padding*    : NkVec2
        colour_factor*  : float32
        disabled_factor*: float32

    NkStyleProperty* = object
        normal*       : NkStyleItem
        hover*        : NkStyleItem
        active*       : NkStyleItem
        border_colour*: NkColour

        label_normal*: NkColour
        label_hover* : NkColour
        label_active*: NkColour

        sym_left* : NkSymbolKind
        sym_right*: NkSymbolKind

        border*         : float32
        rounding*       : float32
        padding*        : NkVec2
        colour_factor*  : float32
        disabled_factor*: float32

        edit*   : NkStyleEdit
        inc_btn*: NkStyleButton
        dec_btn*: NkStyleButton

        user_data* : NkHandle
        draw_begin*: proc(buf: ptr NkCommandBuffer; user_data: NkHandle)
        draw_end*  : proc(buf: ptr NkCommandBuffer; user_data: NkHandle)

    NkStyleChart* = object
        bg*             : NkStyleItem
        border_colour*  : NkColour
        selected_colour*: NkColour
        colour*         : NkColour

        border*         : float32
        rounding*       : float32
        padding*        : NkVec2
        colour_factor*  : float32
        disabled_factor*: float32
        show_markers*   : bool

    NkStyleCombo* = object
        normal*       : NkStyleItem
        hover*        : NkStyleItem
        active*       : NkStyleItem
        border_colour*: NkColour

        label_normal*: NkColour
        label_hover* : NkColour
        label_active*: NkColour

        sym_colour_normal*: NkColour
        sym_colour_hover* : NkColour
        sym_colour_active*: NkColour

        btn*       : NkStyleButton
        sym_normal*: NkSymbolKind
        sym_hover* : NkSymbolKind
        sym_active*: NkSymbolKind

        border*         : float32
        rounding*       : float32
        content_padding*: NkVec2
        btn_padding*    : NkVec2
        spacing*        : NkVec2
        colour_factor*  : float32
        disabled_factor*: float32

    NkStyleTab* = object
        bg*           : NkStyleItem
        border_colour*: NkColour
        text*         : NkColour

        tab_maximize_btn* : NkStyleButton
        tab_minimize_btn* : NkStyleButton
        node_maximize_btn*: NkStyleButton
        node_minimize_btn*: NkStyleButton
        sym_minimize*     : NkSymbolKind
        sym_maximize*     : NkSymbolKind

        border*         : float32
        rounding*       : float32
        indent*         : float32
        padding*        : NkVec2
        spacing*        : NkVec2
        colour_factor*  : float32
        disabled_factor*: float32

    NkStyleWindowHeader* = object
        normal*: NkStyleItem
        hover* : NkStyleItem
        active*: NkStyleItem

        close_btn*   : NkStyleButton
        minimize_btn*: NkStyleButton
        close_sym*   : NkSymbolKind
        minimize_sym*: NkSymbolKind
        maximize_sym*: NkSymbolKind

        label_normal*: NkColour
        label_hover* : NkColour
        label_active*: NkColour

        align*        : NkStyleHeaderAlign
        padding*      : NkVec2
        label_padding*: NkVec2
        spacing*      : NkVec2

    NkStyleWindow* = object
        header*  : NkStyleWindowHeader
        fixed_bg*: NkStyleItem
        bg*      : NkColour

        border_colour*           : NkColour
        popup_border_colour*     : NkColour
        combo_border_colour*     : NkColour
        contextual_border_colour*: NkColour
        menu_border_colour*      : NkColour
        group_border_colour*     : NkColour
        tooltip_border_colour*   : NkColour
        scaler*                  : NkStyleItem

        border*           : float32
        combo_border*     : float32
        contextual_border*: float32
        menu_border*      : float32
        group_border*     : float32
        tooltip_border*   : float32
        popup_border*     : float32
        min_row_h_padding*: float32

        rounding*    : float32
        spacing*     : NkVec2
        scrollbar_sz*: NkVec2
        min_sz*      : NkVec2

        padding*           : NkVec2
        group_padding*     : NkVec2
        popup_padding*     : NkVec2
        combo_padding*     : NkVec2
        contextual_padding*: NkVec2
        menu_padding*      : NkVec2
        tooltip_padding*   : NkVec2

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
