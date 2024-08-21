import common, widget, drawing

{.push size: sizeof(uint32).}
type
    NkWindowFlag* = enum
        nkWinPrivate        = 1 shl 11
        # nkWinDynamic        = nkWinPrivate
        nkWinRom            = 1 shl 12
        # nkWinNotInteractive = nkWinRom or nkWinNoInput
        nkWinHidden         = 1 shl 13
        nkWinclosed         = 1 shl 14
        nkWinMinimized      = 1 shl 15
        nkWinRemoveRom      = 1 shl 16

    NkPanelFlag* = enum
        nkWinBorder         = 1 shl 0
        nkWinMovable        = 1 shl 1
        nkWinScalable       = 1 shl 2
        nkWinClosable       = 1 shl 3
        nkWinMinimizable    = 1 shl 4
        nkWinNoScrollbar    = 1 shl 5
        nkWinTitle          = 1 shl 6
        nkWinScrollAutoHide = 1 shl 7
        nkWinBackground     = 1 shl 8
        nkWinScaleLeft      = 1 shl 9
        nkWinNoInput        = 1 shl 10

    NkPanelKind* = enum
        nkPanelNone       = 0
        nkPanelWindow     = 1 shl 0
        nkPanelGroup      = 1 shl 1
        nkPanelPopup      = 1 shl 2
        nkPanelContextual = 1 shl 4
        nkPanelCombo      = 1 shl 5
        nkPanelMenu       = 1 shl 6
        nkPanelTooltip    = 1 shl 7

    NkPanelSet* = enum A, B
    # NkPanelSet* = enum
        # nkPanelSetNonblock = nkPanelContextual or nkPanelCombo or nkPanelMenu or nkPanelTooltip
        # nkPanelSetPopup    = nkPanelSetNonblock or nkPanelPopup
        # nkPanelSetSub      = nkPanelSetPopup or nkPanelGroup

    NkPanelRowLayoutKind* = enum
        nkLayoutDynamicFixed
        nkLayoutDynamicRow
        nkLayoutDynamicFree
        nkLayoutDynamic
        nkLayoutStaticFixed
        nkLayoutStaticRow
        nkLayoutStaticFree
        nkLayoutStatic
        nkLayoutTemplate
{.pop.} # size: sizeof(uint32)

type NkTable = object
type
    NkWindow* = object
        `seq`*   : uint32
        name*    : NkHash
        name_str*: array[NkWindowMaxName, char]
        flags*   : NkWindowFlag

        bounds*   : NkRect
        scrollbar*: NkScroll
        buf*      : NkCommandBuffer
        layout*   : ptr NkPanel
        scrollbar_hiding_timer*: float32

        prop*    : NkPropertyState
        popup*   : NkPopupState
        edit*    : NkEditState
        scrolled*: uint32
        widgets_disabled*: bool

        tbls*     : ptr NkTable
        tbl_count*: uint32

        next*  : ptr NkWindow
        prev*  : ptr NkWindow
        parent*: ptr NkWindow

    NkPopupState* = object
        win*        : ptr NkWindow
        kind*       : NkPanelKind
        buf*        : NkPopupBuffer
        name*       : NkHash
        active*     : bool
        combo_count*: uint32
        con_count*  : uint32
        con_old*    : uint32
        active_con* : uint32
        header*     : NkRect

    NkEditState* = object
        name*       : NkHash
        `seq`*      : uint32
        old*        : uint32
        active*     : int32
        prev*       : int32
        cursor*     : int32
        sel_start*  : int32
        sel_end*    : int32
        scrollbar*  : NkScroll
        mode*       : uint8
        single_line*: uint8

    NkPropertyState* = object
        active*   : int32
        prev*     : int32
        buf*      : array[NkMaxNumberBuffer, char]
        len*      : int32
        cursor*   : int32
        sel_start*: int32
        sel_end*  : int32
        name*     : NkHash
        `seq`*    : uint32
        old*      : uint32
        state*    : int32

    NkPanel* = object
        kind*         : NkPanelKind
        flags*        : NkPanelFlag
        bounds*       : NkRect
        offset_x*     : ptr uint32
        offset_y*     : ptr uint32
        at_x*, at_y*  : float32
        max_x*        : float32
        footer_h*     : float32
        header_h*     : float32
        border*       : float32
        has_scrolling*: uint32
        clip*         : NkRect
        menu*         : NkMenuState
        row*          : NkRowLayout
        chart*        : NkChart
        buf*          : ptr NkCommandBuffer
        parent*       : ptr NkPanel

    NkRowLayout* = object
        kind*       : NkPanelRowLayoutKind
        index*      : int32
        h*, min_h*  : float32
        cols*       : int32
        ratio*      : ptr float32
        item_w*     : float32
        item_h*     : float32
        item_offset*: float32
        filled*     : float32
        item*       : NkRect
        tree_depth* : int32
        templates*  : array[NkMaxLayoutRowTemplateColumns, float32]

    NkPopupBuffer* = object
        begin* : uint
        parent*: uint
        last*  : uint
        `end`* : uint
        active*: uint

    NkMenuState* = object
        x*, y* : float32
        w*, h* : float32
        offset*: NkScroll

#[ -------------------------------------------------------------------- ]#

using
    ctx  : pointer
    name : cstring
    title: cstring

proc nk_begin*(ctx; title; bounds: NkRect; flags: NkFlag): bool              {.importc: "nk_begin"       .}
proc nk_begin_titled*(ctx; name, title; bounds: NkRect; flags: NkFlag): bool {.importc: "nk_begin_titled".}
proc nk_end*(ctx)                                                            {.importc: "nk_end"         .}

proc nk_window_find*(ctx; name)                                             {.importc: "nk_window_find"                   .}
proc nk_window_get_bounds*(ctx): NkRect                                     {.importc: "nk_window_get_bounds"             .}
proc nk_window_get_position*(ctx): NkVec2                                   {.importc: "nk_window_get_position"           .}
proc nk_window_get_size*(ctx): NkVec2                                       {.importc: "nk_window_get_size"               .}
proc nk_window_get_width*(ctx): float32                                     {.importc: "nk_window_get_width"              .}
proc nk_window_get_height*(ctx): float32                                    {.importc: "nk_window_get_height"             .}
proc nk_window_get_panel*(ctx): ptr NkPanel                                 {.importc: "nk_window_get_panel"              .}
proc nk_window_get_content_region*(ctx): NkRect                             {.importc: "nk_window_get_content_region"     .}
proc nk_window_get_content_region_min*(ctx): NkVec2                         {.importc: "nk_window_get_content_region_min" .}
proc nk_window_get_content_region_max*(ctx): NkVec2                         {.importc: "nk_window_get_content_region_max" .}
proc nk_window_get_content_region_size*(ctx): NkVec2                        {.importc: "nk_window_get_content_region_size".}
proc nk_window_get_canvas*(ctx): ptr NkCommandBuffer                        {.importc: "nk_window_get_canvas"             .}
proc nk_window_get_scroll*(ctx; x_offset, y_offset: ptr uint32)             {.importc: "nk_window_get_scroll"             .}
proc nk_window_has_focus*(ctx): bool                                        {.importc: "nk_window_has_focus"              .}
proc nk_window_is_hovered*(ctx): bool                                       {.importc: "nk_window_is_hovered"             .}
proc nk_window_is_collapsed*(ctx; name): bool                               {.importc: "nk_window_is_collapsed"           .}
proc nk_window_is_closed*(ctx; name): bool                                  {.importc: "nk_window_is_closed"              .}
proc nk_window_is_hidden*(ctx; name): bool                                  {.importc: "nk_window_is_hidden"              .}
proc nk_window_is_active*(ctx; name): bool                                  {.importc: "nk_window_is_active"              .}
proc nk_window_is_any_hovered*(ctx): bool                                   {.importc: "nk_window_is_any_hovered"         .}
proc nk_window_is_any_active*(ctx): bool                                    {.importc: "nk_window_is_any_active"          .}
proc nk_window_set_bounds*(ctx; name; bounds: NkRect)                       {.importc: "nk_window_set_bounds"             .}
proc nk_window_set_position*(ctx; name; pos: NkVec2)                        {.importc: "nk_window_set_position"           .}
proc nk_window_set_size*(ctx; name; sz: NkVec2)                             {.importc: "nk_window_set_size"               .}
proc nk_window_set_focus*(ctx; name)                                        {.importc: "nk_window_set_focus"              .}
proc nk_window_set_scroll*(ctx; name; x_offset, y_offset: uint32)           {.importc: "nk_window_set_scroll"             .}
proc nk_window_close*(ctx; name)                                            {.importc: "nk_window_close"                  .}
proc nk_window_collapse*(ctx; name; state: NkCollapseState)                 {.importc: "nk_window_collapse"               .}
proc nk_window_collapse_if*(ctx; name; state: NkCollapseState; cond: int32) {.importc: "nk_window_collapse_if"            .}
proc nk_window_show*(ctx; name; state: NkShowState)                         {.importc: "nk_window_show"                   .}
proc nk_window_show_if*(ctx; name; state: NkShowState; cond: int32)         {.importc: "nk_window_show_if"                .}

proc nk_rule_horizontal*(ctx; colour: NkColour; rounding: bool) {.importc: "nk_rule_horizontal".}

proc nk_group_begin*(ctx; title; flags: NkFlag): bool                                           {. importc: "nk_group_begin"                 .}
proc nk_group_begin_titled*(ctx; name, title; flags: NkFlag): bool                              {. importc: "nk_group_begin_titled"          .}
proc nk_group_end*(ctx)                                                                         {. importc: "nk_group_end"                   .}
proc nk_group_scrolled_offset_begin*(ctx; x_offset, y_offset: ptr uint32; title; flags: NkFlag) {. importc: "nk_group_scrolled_offset_begin" .}
proc nk_group_scrolled_begin*(ctx; offset: ptr NkScroll; title; flags: NkFlag)                  {. importc: "nk_group_scrolled_begin"        .}
proc nk_group_scrolled_end*(ctx)                                                                {. importc: "nk_group_scrolled_end"          .}
proc nk_group_get_scroll*(ctx; id: cstring; x_offset, y_offset: ptr uint32)                     {. importc: "nk_group_get_scroll"            .}
proc nk_group_set_scroll*(ctx; id: cstring; x_offset, y_offset: uint32)                         {. importc: "nk_group_set_scroll"            .}
