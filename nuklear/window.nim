import bitgen, common, widget, drawing

type PanelFlag* = distinct uint32
PanelFlag.gen_bit_ops(
    winBorder     , winMovable    , winScalable, winClosable,
    winMinimizable, winNoScrollbar, winTitle   , winScrollAutoHide,
    winBackground , winScaleLeft  , winNoInput ,
)

type WindowFlag* = distinct uint32
WindowFlag.gen_bit_ops(
    _, _, _, _,
    _, _, _, _,
    _, _, _, winPrivate,
    winRom, winHidden, winClosed, winMinimized,
    winRemoveRom,
)
const winDynamic*        = winPrivate
const winNotInteractive* = winRom or (WindowFlag winNoInput)

type PanelKindFlag* = distinct uint32
PanelKindFlag.gen_bit_ops(
    panelWindow    , panelGroup, panelPopup, _,
    panelContextual, panelCombo, panelMenu , panelTooltip,
)
const panelNone* = PanelKindFlag 0

const
    PSetNonBlock = panelContextual or panelCombo or panelMenu or panelTooltip
    PSetPopup    = PSetNonBlock or panelPopup
    PSetSub      = PSetPopup or panelGroup
type
    PanelSet* {.size: sizeof(Flag).} = enum
        panelSetNonBlock = PSetNonBlock
        panelSetPopup    = PSetPopup
        panelSetSub      = PSetSub

    PanelRowLayout* {.size: sizeof(Flag).} = enum
        layoutDynamicFixed
        layoutDynamicRow
        layoutDynamicFree
        layoutDynamic
        layoutStaticFixed
        layoutStaticRow
        layoutStaticFree
        layoutStatic
        layoutTemplate

type
    Table = object

    Window* = object
        `seq`*   : cuint
        name*    : Hash
        name_str*: array[NkWindowMaxName, char]
        flags*   : WindowFlag

        bounds*                : Rect
        scrollbar*             : Scroll
        buf*                   : CommandBuffer
        layout*                : ptr Panel
        scrollbar_hiding_timer*: cfloat

        prop*            : PropertyState
        popup*           : PopupState
        edit*            : EditState
        scrolled*        : cuint
        widgets_disabled*: bool

        tbls*     : ptr Table
        tbl_count*: cuint

        next*  : ptr Window
        prev*  : ptr Window
        parent*: ptr Window

    PopupState* = object
        win*        : ptr Window
        kind*       : PanelKindFlag
        buf*        : PopupBuffer
        name*       : Hash
        active*     : bool
        combo_count*: cuint
        con_count*  : cuint
        con_old*    : cuint
        active_con* : cuint
        header*     : Rect

    EditState* = object
        name*       : Hash
        `seq`*      : cuint
        old*        : cuint
        active*     : cint
        prev*       : cint
        cursor*     : cint
        sel_start*  : cint
        sel_end*    : cint
        scrollbar*  : Scroll
        mode*       : uint8
        single_line*: uint8

    PropertyState* = object
        active*   : cint
        prev*     : cint
        buf*      : array[NkMaxNumberBuffer, char]
        len*      : cint
        cursor*   : cint
        sel_start*: cint
        sel_end*  : cint
        name*     : Hash
        `seq`*    : cuint
        old*      : cuint
        state*    : cint

    Panel* = object
        kind*         : PanelKindFlag
        flags*        : PanelFlag
        bounds*       : Rect
        offset_x*     : ptr uint32
        offset_y*     : ptr uint32
        at_x*, at_y*  : cfloat
        max_x*        : cfloat
        footer_h*     : cfloat
        header_h*     : cfloat
        border*       : cfloat
        has_scrolling*: cuint
        clip*         : Rect
        menu*         : MenuState
        row*          : RowLayout
        chart*        : Chart
        buf*          : ptr CommandBuffer
        parent*       : ptr Panel

    RowLayout* = object
        kind*       : PanelRowLayout
        index*      : cint
        h*, min_h*  : cfloat
        cols*       : cint
        ratio*      : ptr cfloat
        item_w*     : cfloat
        item_h*     : cfloat
        item_offset*: cfloat
        filled*     : cfloat
        item*       : Rect
        tree_depth* : cint
        templates*  : array[NkMaxLayoutRowTemplateColumns, cfloat]

    PopupBuffer* = object
        begin* : uint
        parent*: uint
        last*  : uint
        `end`* : uint
        active*: uint

    MenuState* = object
        x*, y* : cfloat
        w*, h* : cfloat
        offset*: Scroll

#[ -------------------------------------------------------------------- ]#

using
    ctx  : pointer
    name : cstring
    title: cstring

proc nk_begin*(ctx; title; bounds: Rect; flags: Flag): bool              {.importc: "nk_begin"       .}
proc nk_begin_titled*(ctx; name, title; bounds: Rect; flags: Flag): bool {.importc: "nk_begin_titled".}
proc nk_end*(ctx)                                                        {.importc: "nk_end"         .}

proc nk_window_find*(ctx; name)                                          {.importc: "nk_window_find"                   .}
proc nk_window_get_bounds*(ctx): Rect                                    {.importc: "nk_window_get_bounds"             .}
proc nk_window_get_position*(ctx): Vec2                                  {.importc: "nk_window_get_position"           .}
proc nk_window_get_size*(ctx): Vec2                                      {.importc: "nk_window_get_size"               .}
proc nk_window_get_width*(ctx): cfloat                                   {.importc: "nk_window_get_width"              .}
proc nk_window_get_height*(ctx): cfloat                                  {.importc: "nk_window_get_height"             .}
proc nk_window_get_panel*(ctx): ptr Panel                                {.importc: "nk_window_get_panel"              .}
proc nk_window_get_content_region*(ctx): Rect                            {.importc: "nk_window_get_content_region"     .}
proc nk_window_get_content_region_min*(ctx): Vec2                        {.importc: "nk_window_get_content_region_min" .}
proc nk_window_get_content_region_max*(ctx): Vec2                        {.importc: "nk_window_get_content_region_max" .}
proc nk_window_get_content_region_size*(ctx): Vec2                       {.importc: "nk_window_get_content_region_size".}
proc nk_window_get_canvas*(ctx): ptr CommandBuffer                       {.importc: "nk_window_get_canvas"             .}
proc nk_window_get_scroll*(ctx; x_offset, y_offset: ptr uint32)          {.importc: "nk_window_get_scroll"             .}
proc nk_window_has_focus*(ctx): bool                                     {.importc: "nk_window_has_focus"              .}
proc nk_window_is_hovered*(ctx): bool                                    {.importc: "nk_window_is_hovered"             .}
proc nk_window_is_collapsed*(ctx; name): bool                            {.importc: "nk_window_is_collapsed"           .}
proc nk_window_is_closed*(ctx; name): bool                               {.importc: "nk_window_is_closed"              .}
proc nk_window_is_hidden*(ctx; name): bool                               {.importc: "nk_window_is_hidden"              .}
proc nk_window_is_active*(ctx; name): bool                               {.importc: "nk_window_is_active"              .}
proc nk_window_is_any_hovered*(ctx): bool                                {.importc: "nk_window_is_any_hovered"         .}
proc nk_window_is_any_active*(ctx): bool                                 {.importc: "nk_window_is_any_active"          .}
proc nk_window_set_bounds*(ctx; name; bounds: Rect)                      {.importc: "nk_window_set_bounds"             .}
proc nk_window_set_position*(ctx; name; pos: Vec2)                       {.importc: "nk_window_set_position"           .}
proc nk_window_set_size*(ctx; name; sz: Vec2)                            {.importc: "nk_window_set_size"               .}
proc nk_window_set_focus*(ctx; name)                                     {.importc: "nk_window_set_focus"              .}
proc nk_window_set_scroll*(ctx; name; x_offset, y_offset: uint32)        {.importc: "nk_window_set_scroll"             .}
proc nk_window_close*(ctx; name)                                         {.importc: "nk_window_close"                  .}
proc nk_window_collapse*(ctx; name; state: CollapseState)                {.importc: "nk_window_collapse"               .}
proc nk_window_collapse_if*(ctx; name; state: CollapseState; cond: cint) {.importc: "nk_window_collapse_if"            .}
proc nk_window_show*(ctx; name; state: ShowState)                        {.importc: "nk_window_show"                   .}
proc nk_window_show_if*(ctx; name; state: ShowState; cond: cint)         {.importc: "nk_window_show_if"                .}

proc nk_rule_horizontal*(ctx; colour: Colour; rounding: bool) {.importc: "nk_rule_horizontal".}

proc nk_group_begin*(ctx; title; flags: Flag): bool                                           {. importc: "nk_group_begin"                 .}
proc nk_group_begin_titled*(ctx; name, title; flags: Flag): bool                              {. importc: "nk_group_begin_titled"          .}
proc nk_group_end*(ctx)                                                                       {. importc: "nk_group_end"                   .}
proc nk_group_scrolled_offset_begin*(ctx; x_offset, y_offset: ptr uint32; title; flags: Flag) {. importc: "nk_group_scrolled_offset_begin" .}
proc nk_group_scrolled_begin*(ctx; offset: ptr Scroll; title; flags: Flag)                    {. importc: "nk_group_scrolled_begin"        .}
proc nk_group_scrolled_end*(ctx)                                                              {. importc: "nk_group_scrolled_end"          .}
proc nk_group_get_scroll*(ctx; id: cstring; x_offset, y_offset: ptr uint32)                   {. importc: "nk_group_get_scroll"            .}
proc nk_group_set_scroll*(ctx; id: cstring; x_offset, y_offset: uint32)                       {. importc: "nk_group_set_scroll"            .}
