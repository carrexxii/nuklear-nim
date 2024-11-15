import bitgen, defines

type WidgetAlign* = distinct uint32
WidgetAlign.gen_bit_ops(
    widgetAlignLeft, widgetAlignCentred, widgetAlignRight, widgetAlignTop,
    widgetAlignMiddle, widgetAlignBottom,
)

type WidgetState* = distinct uint32
WidgetState.gen_bit_ops(
    stateModified, stateInactive, stateEntered, stateHover,
    stateActivated, stateLeft,
)
const stateHovered* = stateHover or stateModified
const stateActive*  = stateActivated or stateModified

type TextAlign* = distinct uint32
TextAlign.gen_bit_ops(
    textAlignLeft, textAlignCentred, textAlignRight, textAlignTop,
    textAlignMiddle, textAlignBottom,
)

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

type ConvertResult* = distinct uint32
ConvertResult.gen_bit_ops convertInvalidParam, convertCmdBufFull, convertVtxBufFull, convertElemBufFull
const convertSuccess* = ConvertResult 0

const # This is for `PanelSet`
    PSetNonBlock = panelContextual or panelCombo or panelMenu or panelTooltip
    PSetPopup    = PSetNonBlock or panelPopup
    PSetSub      = PSetPopup or panelGroup

{.push size: sizeof(Flag).}
type
    Heading* = enum
        headingUp
        headingRight
        headingDown
        headingLeft

    ButtonBehaviour* = enum
        btnDefault
        btnRepeater

    Modify* = enum
        modifyFixed
        modifyModifiable

    Orientation* = enum
        orientVertical
        orientHorizontal

    CollapseState* = enum
        collapseMinimized
        collapseMaximized

    ShowState* = enum
        showHidden
        showShown

    ChartEvent* = enum
        chartHovering = 0x01
        chartClicked  = 0x02

    ColourFormat* = enum
        colourRgb
        colourRgba

    PopupKind* = enum
        popupStatic
        popupDynamic

    LayoutFormat* = enum
        layoutDynamic
        layoutStatic

    SymbolKind* = enum
        symNone
        symX
        symUnderscore
        symCircleSolid
        symCircleOutline
        symRectSolid
        symRectOutline
        symTriUp
        symTriDown
        symTriLeft
        symTriRight
        symPlus
        symMinus
        symTriUpOutline
        symTriDownOutline
        symTriLeftOutline
        symTriRightOutline

    AllocationKind* = enum
        allocFixed
        allocDynamic

    BufferAllocationKind* = enum
        bufAllocFront
        bufAllocBack

    #[ ---------------------------------------------------------------- ]#

    AntiAliasing* = enum
        aaOff
        aaOn

    DrawVertexLayoutAttribute* = enum
        vtxPosition
        vtxColour
        vtxTexcoord

    DrawVertexLayoutFormat* = enum
        fmtSchar
        fmtSshort
        fmtSint
        fmtUchar
        fmtUshort
        fmtUint
        fmtFloat
        fmtDouble

        fmtR8G8B8
        fmtR16G15B16
        fmtR32G32B32
        fmtR8G8B8A8
        fmtB8G8R8A8
        fmtR16G15B16A16
        fmtR32G32B32A32
        fmtR32G32B32A32Float
        fmtR32G32B32A32Double
        fmtRgb32
        fmtRgba32

    CommandKind* = enum
        cmdNop
        cmdScissor
        cmdLine
        cmdCurve
        cmdRect
        cmdRectFilled
        cmdRectMultiColour
        cmdCircle
        cmdCircleFilled
        cmdArc
        cmdArcFilled
        cmdTriangle
        cmdTriangleFilled
        cmdPolygon
        cmdPolygonFilled
        cmdPolyline
        cmdText
        cmdImage
        cmdCustom

    CommandClipping* = enum
        clippingOff = false
        clippingOn  = true

    DrawListStroke* = enum
        strokeOpen   = false
        strokeClosed = true

    #[ ---------------------------------------------------------------- ]#

    FontAtlasFormat* = enum
        fontAtlasAlpha8
        fontAtlasRgba32

    FontCoordKind* = enum
        fontCoordUv
        fontCoordPixel
    
    #[ ---------------------------------------------------------------- ]#

    KeyKind* = enum
        keyNone
        keyShift
        keyCtrl
        keyDel
        keyEnter
        keyTab
        keyBackspace
        keyCopy
        keyCut
        keyPaste
        keyUp
        keyDown
        keyLeft
        keyRight
        keyTextInsertMode
        keyTextReplaceMode
        keyTextResetMode
        keyTextLineStart
        keyTextLineEnd
        keyTextStart
        keyTextEnd
        keyTextUndo
        keyTextRedo
        keyTextSelectAll
        keyTextWordLeft
        keyTextWordRight
        keyScrollStart
        keyScrollEnd
        keyScrollDown
        keyScrollUp

    Button* = enum
        btnLeft
        btnMiddle
        btnRight
        btnDouble

    #[ ---------------------------------------------------------------- ]#

    WidgetAlignment* = enum
        alignLeft    = widgetAlignMiddle or widgetAlignLeft
        alignCentred = widgetAlignMiddle or widgetAlignCentred
        alignRight   = widgetAlignMiddle or widgetAlignRight

    #[ ---------------------------------------------------------------- ]#

    StyleColours* = enum
        colourText
        colourWin
        colourHeader
        colourBorder
        colourBtn
        colourBtnHover
        colourBtnActive
        colourToggle
        colourToggleHover
        colourToggleCursor
        colourSelect
        colourSelectActive
        colourSlider
        colourSliderCursor
        colourSliderCursorHover
        colourSliderCursorActive
        colourProp
        colourEdit
        colourEditCursor
        colourCombo
        colourChart
        colourChartColour
        colourChartColourHighlight
        colourScrollbar
        colourScrollbarCursor
        colourScrollbarCursorHover
        colourScrollbarCursorActive
        colourTabHeader

    StyleCursor* = enum
        cursorArrow
        cursorText
        cursorMove
        cursorResizeVertical
        cursorResizeHorizontal
        cursorResizeTopLeftDownRight
        cursorResizeTopRightDownLeft

    StyleItemKind* = enum
        itemColour
        itemImage
        itemNineSlice

    StyleHeaderAlign* = enum
        alignLeft
        alignRight

    #[ ---------------------------------------------------------------- ]#

    TextAlignment* = enum
        alignLeft    = textAlignMiddle or textAlignLeft
        alignCentred = textAlignMiddle or textAlignCentred
        alignRight   = textAlignMiddle or textAlignRight

    TextEditKind* = enum
        editSingleLine
        editMultiline

    TextEditMode* = enum
        modeView
        modeInsert
        modeReplace

    #[ ---------------------------------------------------------------- ]#

    TreeKind* = enum
        treeNode
        treeTab

    #[ ---------------------------------------------------------------- ]#

    WidgetLayoutState* = enum
        layoutInvalid
        layoutValid
        layoutRom
        layoutDisabled

    ChartKind* = enum
        chartLine
        chartColumn

    #[ ---------------------------------------------------------------- ]#

    PanelSet* = enum
        panelSetNonBlock = PSetNonBlock
        panelSetPopup    = PSetPopup
        panelSetSub      = PSetSub

    PanelRowLayout* = enum
        layoutDynamicFixed
        layoutDynamicRow
        layoutDynamicFree
        layoutDynamic
        layoutStaticFixed
        layoutStaticRow
        layoutStaticFree
        layoutStatic
        layoutTemplate
{.pop.} # size: sizeof(Flag)

const FmtColourStart* = fmtR8G8B8
const FmtColourEnd*   = fmtRgba32

when defined NkUintDrawIndex:
    type DrawIndex* = cuint
else:
    type DrawIndex* = cushort

type
    Hash* = distinct uint32
    Flag* = distinct uint32
    Rune* = distinct uint32

    Colour* = object
        r*, g*, b*, a*: uint8

    ColourF* = object
        r*, g*, b*, a*: float32

    Vec2I* = object
        x*, y*: int16

    Vec2* = object
        x*, y*: float32

    RectI* = object
        x*, y*, w*, h*: int16

    Rect* = object
        x*, y*, w*, h*: float32

    Glyph* = array[NkUtfSize, char]

    Handle* {.union.} = object
        p* : pointer
        id*: int32

    Image* = object
        handle*: Handle
        w*, h* : uint16
        region*: array[4, uint16]

    NineSlice* = object
        img*  : Image
        l*, t*: uint16
        r*, b*: uint16

    Cursor* = object
        img*   : Image
        sz*    : Vec2
        offset*: Vec2

    Scroll* = object
        x*, y*: uint32

    String* = object
        buf*: Buffer
        len*: int32

    PluginAlloc*  = proc(handle: Handle; old: pointer; sz: uint): pointer {.cdecl.}
    PluginFree*   = proc(handle: Handle; old: pointer) {.cdecl.}
    PluginFilter* = proc(text_edit: pointer; unicode: Rune): bool {.cdecl.}
    PluginPaste*  = proc(handle: Handle; text_edit: pointer) {.cdecl.}
    PluginCopy*   = proc(handle: Handle; str: cstring; len: int32) {.cdecl.}

    MemoryStatus* = object
        mem*    : pointer
        kind*   : cuint
        sz*     : uint
        alloced*: uint
        needed* : uint
        calls*  : uint

    BufferMarker* = object
        active*: bool
        offset*: uint

    Memory* = object
        mem*: pointer
        sz* : uint

    Allocator* = object
        user_data*: Handle
        alloc*    : PluginAlloc
        free*     : PluginFree

    Buffer* = object
        markers*    : array[1 + int BufferAllocationKind.high, BufferMarker]
        pool*       : Allocator
        kind*       : AllocationKind
        mem*        : Memory
        grow_factor*: float32
        alloced*    : uint
        needed*     : uint
        calls*      : uint
        sz*         : uint

    #[ ---------------------------------------------------------------- ]#

    Context* = object
        input*            : Input
        style*            : Style
        mem*              : Buffer
        clip*             : Clipboard
        last_widget_state*: Flag
        btn_behaviour*    : ButtonBehaviour
        stacks*           : ConfigurationStacks
        dt_secs*          : cfloat
        when defined NkIncludeVertexBufferOutput:
            draw_lst*: DrawList
        when defined NkIncludeCommandUserData:
            user_data*: Handle
        text_edit*: TextEdit
        overlay*  : CommandBuffer
        build*    : cint
        use_pool* : cint
        pool*     : Pool
        begin*    : ptr Window
        `end`*    : ptr Window
        active*   : ptr Window
        current*  : ptr Window
        free_lst* : ptr PageElement
        count*    : cuint
        `seq`*    : cuint

    Table* = object
        `seq`*: cuint
        sz*   : cuint
        keys* : array[NkValuePageCapacity, Hash]
        vals* : array[NkValuePageCapacity, cuint]
        next* : ptr Table
        prev* : ptr Table

    PageData* {.union.} = object
        tbl*: Table
        pan*: Panel
        win*: Window

    PageElement* = object
        data*: PageData
        next*: ptr PageElement
        prev*: ptr PageElement

    Page* = object
        sz*  : cuint
        next*: ptr Page
        win* : array[1, PageElement]

    Pool* = object
        alloc*     : Allocator
        kind*      : AllocationKind
        page_count*: cuint
        pages*     : ptr UncheckedArray[Page]
        free_lst*  : ptr UncheckedArray[PageElement]
        cap*       : cuint
        sz*        : uint
        capacity*  : uint

    #[ ---------------------------------------------------------------- ]#

    CommandCustomCallback* = proc(canvas: pointer; x, y: cshort; w, h: cushort; cb_data: Handle) {.cdecl.}

    DrawNullTexture* = object
        tex*: Handle
        uv* : Vec2

    ConvertConfig* = object
        global_alpha*    : cfloat
        line_aa*         : AntiAliasing
        shape_aa*        : AntiAliasing
        circle_seg_count*: cuint
        arc_seg_count*   : cuint
        curve_seg_count* : cuint
        tex_null*        : DrawNullTexture
        vtx_layout*      : ptr DrawVertexLayoutElement
        vtx_sz*          : uint
        vtx_align*       : uint

    DrawVertexLayoutElement* = object
        attr*  : DrawVertexLayoutAttribute
        fmt*   : DrawVertexLayoutFormat
        offset*: uint

    CommandBuffer* = object
        base*        : ptr Buffer
        clip*        : Rect
        use_clipping*: cint
        user_data*   : Handle
        begin*       : uint
        `end`*       : uint
        last*        : uint

    DrawCommand* = object
        elem_count*: cuint
        clip_rect* : Rect
        tex*       : Handle
        when defined NkIncludeCommandUserData:
            user_data*: Handle

    DrawList* = object
        clip_rect*  : Rect
        circle_vtx* : array[12, Vec2]
        cfg*        : ConvertConfig
        buf*        : Buffer
        vertices*   : Buffer
        elems*      : Buffer
        elem_count* : cuint
        vtx_count*  : cuint
        cmd_count*  : cuint
        cmd_offset* : uint
        path_count* : cuint
        path_offset*: cuint
        line_aa*    : AntiAliasing
        shape_aa*   : AntiAliasing
        when defined NkIncludeCommandUserData:
            user_data*: Handle

    Command* = object
        kind*: CommandKind
        next*: uint
        when defined NkIncludeCommandUserData:
            user_data*: Handle

    CommandScissor* = object
        header*: Command
        x*, y* : cshort
        w*, h* : cushort

    CommandLine* = object
        header*   : Command
        thickness*: cushort
        begin*    : Vec2I
        `end`*    : Vec2I
        colour*   : Colour

    CommandCurve* = object
        header*   : Command
        thickness*: cushort
        begin*    : Vec2I
        `end`*    : Vec2I
        ctrl*     : array[2, Vec2I]
        colour*   : Colour

    CommandRect* = object
        header*   : Command
        rounding* : cushort
        thickness*: cushort
        x*, y*    : cshort
        w*, h*    : cushort
        colour*   : Colour

    CommandRectFilled* = object
        header*  : Command
        rounding*: cushort
        x*, y*   : cshort
        w*, h*   : cushort
        colour*  : Colour

    CommandRectMultiColour* = object
        header*: Command
        x*, y* : cshort
        left*  : Colour
        top*   : Colour
        bottom*: Colour
        right* : Colour

    CommandTriangle* = object
        header*   : Command
        thickness*: cushort
        a*, b*, c*: Vec2I
        colour*   : Colour

    CommandTriangleFilled* = object
        header*   : Command
        a*, b*, c*: Vec2I
        colour*   : Colour

    CommandCircle* = object
        header*   : Command
        x*, y*    : cshort
        thickness*: cushort
        w*, h*    : cushort
        colour*   : Colour

    CommandCircleFilled* = object
        header*: Command
        x*, y* : cshort
        w*, h* : cushort
        colour*: Colour

    CommandArc* = object
        header*   : Command
        cx*, cy*  : cshort
        r*        : cushort
        thickness*: cushort
        a*        : array[2, cfloat]
        colour*   : Colour

    CommandArcFilled* = object
        header* : Command
        cx*, cy*: cshort
        r*      : cushort
        a*      : array[2, cfloat]
        colour* : Colour

    CommandPolygon* = object
        header*   : Command
        colour*   : Colour
        thickness*: cushort
        pt_count* : cushort
        pts*      : array[1, Vec2I]

    CommandPolygonFilled* = object
        header*  : Command
        colour*  : Colour
        pt_count*: cushort
        pts*     : array[1, Vec2I]

    CommandPolyline* = object
        header*   : Command
        colour*   : Colour
        thickness*: cushort
        pt_count* : cushort
        pts*      : array[1, Vec2I]

    CommandImage* = object
        header*: Command
        x*, y* : cshort
        w*, h* : cushort
        img*   : Image
        colour*: Colour

    CommandCustom* = object
        header* : Command
        x*, y*  : cshort
        w*, h*  : cushort
        cb_data*: Handle
        cb*     : CommandCustomCallback

    CommandText* = object
        header* : Command
        font*   : UserFont
        bg*, fg*: Colour
        x*, y*  : cshort
        w*, h*  : cushort
        height* : cfloat
        len*    : cint
        str*    : array[1, char]

    #[ ---------------------------------------------------------------- ]#

    TextWidthFn*      = proc(handle: Handle; h: cfloat; text: cstring; len: cint): cfloat
    QueryFontGlyphFn* = proc(handle: Handle; font_h: cfloat; glyph: ptr UserFontGlyph; codepoint, next_codepoint: Rune)

    UserFont* = object
        user_data*: Handle
        h*        : cfloat
        w*        : TextWidthFn
        when defined NkIncludeVertexBufferOutput:
            query*: QueryFontGlyphFn
            tex*  : Handle

    UserFontGlyph* = object
        uvs*      : array[2, Vec2]
        offset*   : Vec2
        w*, h*    : cfloat
        x_advance*: cfloat

    FontGlyph* = object
        codepoint*: Rune
        x0*, y0*  : cfloat
        x1*, y1*  : cfloat
        w*, h*    : cfloat
        u0*, v0*  : cfloat
        u1*, v1*  : cfloat

    Font* = object
        next*              : ptr Font
        handle*            : UserFont
        info*              : BakedFont
        scale*             : cfloat
        glyphs*            : ptr FontGlyph
        fallback*          : ptr FontGlyph
        fallback_codepoint*: Rune
        tex*               : Handle
        cfg*               : ptr FontConfig

    BakedFont* = object
        h*           : cfloat
        ascent*      : cfloat
        descent*     : cfloat
        glyph_offset*: Rune
        glyph_count* : Rune
        ranges*      : ptr Rune

    FontConfig* = object
        next*    : ptr FontConfig
        ttf_blob*: pointer
        ttf_sz*  : uint

        ttf_data_owned_by_atlas*: uint8
        merge_mode*             : uint8
        px_snap*                : uint8
        oversample_v*           : uint8
        oversample_h*           : uint8
        _*                      : array[3, byte]

        sz*            : cfloat
        coord_kind*    : FontCoordKind
        spacing*       : Vec2
        range*         : ptr Rune
        font*          : ptr BakedFont
        fallback_glyph*: Rune
        n*             : ptr FontConfig
        p*             : ptr FontConfig

    FontAtlas* = object
        pxs*  : pointer
        w*, h*: cint

        permanent*: Allocator
        temporary*: Allocator

        custom* : RectI
        cursors*: array[7, Cursor] # NkStyleCursor.high

        glyph_count* : cint
        glyphs*      : ptr FontGlyph
        default_font*: ptr Font
        fonts*       : ptr Font
        cfg*         : ptr FontConfig
        font_count*  : cint

    #[ ---------------------------------------------------------------- ]#

    MouseButton* = object
        down*       : bool
        clicked*    : cuint
        clicked_pos*: Vec2

    Mouse* = object
        btns*: array[1 + int Button.high, MouseButton]
        pos* : Vec2
        when defined NkButtonTriggerOnRelease:
            down_pos*: Vec2
        prev*        : Vec2
        delta*       : Vec2
        scroll_delta*: Vec2
        grab*        : uint8
        grabbed*     : uint8
        ungrab*      : uint8

    Key* = object
        down*   : bool
        clicked*: cuint

    Keyboard* = object
        keys*   : array[1 + int KeyKind.high, Key]
        txt*    : array[NkInputMax, char]
        txt_len*: cint

    Input* = object
        keyboard*: Keyboard
        mouse*   : Mouse

    #[ ---------------------------------------------------------------- ]#

    ConfigurationStacks* = object
        style_items*   : ConfigStackStyle
        floats*        : ConfigStackFloat
        vectors*       : ConfigStackVec2
        flags*         : ConfigStackFlag
        colours*       : ConfigStackColour
        user_fonts*    : ConfigStackUserFont
        btn_behaviours*: ConfigStackButtonBehaviour

    ConfigStackStyle* = object
        head* : cint
        elems*: array[NkStyleItemStackSize, tuple[address: ptr StyleItem, old_val: StyleItem]]
    ConfigStackFloat* = object
        head* : cint
        elems*: array[NkFloatStackSize, tuple[address: ptr cfloat, old_val: cfloat]]
    ConfigStackVec2* = object
        head* : cint
        elems*: array[NkVec2StackSize, tuple[address: ptr Vec2, old_val: Vec2]]
    ConfigStackFlag* = object
        head* : cint
        elems*: array[NkFlagStackSize, tuple[address: ptr Flag, old_val: Flag]]
    ConfigStackColour* = object
        head* : cint
        elems*: array[NkColourStackSize, tuple[address: ptr Colour, old_val: Colour]]
    ConfigStackUserFont* = object
        head* : cint
        elems*: array[NkUserFontStackSize, tuple[address: ptr UserFont, old_val: UserFont]]
    ConfigStackButtonBehaviour* = object
        head* : cint
        elems*: array[NkButtonBehaviourStackSize, tuple[address: ptr ButtonBehaviour, old_val: ButtonBehaviour]]

    #[ ---------------------------------------------------------------- ]#

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
        selectable*    : StyleSelectable
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

    #[ ---------------------------------------------------------------- ]#

    TextEdit* = object
        clip*     : Clipboard
        str*      : String
        filter*   : PluginFilter
        scrollbar*: Vec2

        cursor*   : cint
        sel_start*: cint
        sel_end*  : cint
        mode*     : uint8

        cursor_at_end_of_line*: uint8
        initialized*          : uint8
        has_preferred_x*      : uint8
        single_line*          : uint8
        active*               : uint8
        _                     : uint8
        preferred_x*          : cfloat
        undo*                 : TextUndoState

    Clipboard* = object
        user_data*: Handle
        paste*    : PluginPaste
        copy*     : PluginCopy

    TextUndoRecord* = object
        where*       : cint
        ins_len*     : cshort
        del_len*     : cshort
        char_storage*: cshort

    TextUndoState* = object
        undo_rec*       : array[NkTextEditUndoStateCount, TextUndoRecord]
        undo_char*      : array[NkTextEditUndoCharCount, Rune]
        undo_point*     : cshort
        redo_point*     : cshort
        undo_char_point*: cshort
        redo_char_point*: cshort

    #[ ---------------------------------------------------------------- ]#

    ChartSlot* = object
        kind*        : ChartKind
        colour*      : Colour
        highlight*   : Colour
        min*, max*   : cfloat
        range*       : cfloat
        count*       : cint
        last*        : Vec2
        index*       : cint
        show_markers*: bool

    Chart* = object
        slot* : cint
        x*, y*: cfloat
        w*, h*: cfloat
        slots*: array[NkChartMaxSlots, ChartSlot]

    #[ ---------------------------------------------------------------- ]#

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
