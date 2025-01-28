import bitgen, defines

type WidgetAlignFlag* = distinct uint32
WidgetAlignFlag.gen_bit_ops(
    wafLeft, wafCentred, wafRight, wafTop,
    wafMiddle, wafBottom,
)

type WidgetStateFlag* = distinct uint32
WidgetStateFlag.gen_bit_ops(
    wsfModified , wsfInactive, wsfEntered, wsfHover,
    wsfActivated, wsfLeft,
)
const wsfHovered* = wsfHover or wsfModified
const wsfActive*  = wsfActivated or wsfModified

type TextAlignFlag* = distinct uint32
TextAlignFlag.gen_bit_ops(
    tafLeft, tafCentred, tafRight, tafTop,
    tafMiddle, tafBottom,
)

type PanelFlag* = distinct uint32
PanelFlag.gen_bit_ops(
    pfBorder     , pfMovable    , pfScalable, pfClosable,
    pfMinimisable, pfNoScrollbar, pfTitle   , pfScrollAutoHide,
    pfBackground , pfScaleLeft  , pfNoInput ,
)
const pfNone* = PanelFlag 0

type WindowFlag* = distinct uint32
WindowFlag.gen_bit_ops(
    _, _, _, _,
    _, _, _, _,
    _, _, _, wfPrivate,
    wfRom, wfHidden, wfClosed, wfMinimised,
    wfRemoveRom,
)
const wfNone*           = WindowFlag 0
const wfDynamic*        = wfPrivate
const wfNotInteractive* = wfRom or (WindowFlag pfNoInput)

type PanelKindFlag* = distinct uint32
PanelKindFlag.gen_bit_ops(
    pkfWindow    , pkfGroup, pkfPopup, _,
    pkfContextual, pkfCombo, pkfMenu , pkfTooltip,
)
const pkfNone* = PanelKindFlag 0

type ConvertResultFlag* = distinct uint32
ConvertResultFlag.gen_bit_ops crfInvalidParam, crfCmdBufFull, crfVtxBufFull, crfElemBufFull
const crfSuccess* = ConvertResultFlag 0

type EditFlag* = distinct uint32
EditFlag.gen_bit_ops(
    efReadOnly          , efAutoSelect      , efSigEnter , efAllowTab,
    efNoCursor          , efSelectable      , efClipboard, efCtrlEnterNewline,
    efNoHorizontalScroll, efAlwaysInsertMode, efMultiline, efGotoEndOnActivate,
)
const efDefault* = EditFlag 0

type EditEventFlag* = distinct uint32
EditEventFlag.gen_bit_ops eefActive, eefInactive, eefActivated, eefDeactivated, eefCommited

type ChartEvent* = distinct uint32
ChartEvent.gen_bit_ops ceHovering, ceClicked

#[ -------------------------------------------------------------------- ]#

const
    # This is for `PanelSet`
    PSetNonBlock = pkfContextual or pkfCombo or pkfMenu or pkfTooltip
    PSetPopup    = PSetNonBlock or pkfPopup
    PSetSub      = PSetPopup or pkfGroup

    # This is for `EditKind`
    EKindSimple = efAlwaysInsertMode
    EKindField  = EKindSimple or efSelectable or efClipboard
    EKindBox    = efAlwaysInsertMode or efSelectable or efMultiline or efAllowTab or efClipboard
    EKindEditor = efSelectable or efMultiline or efAllowTab or efClipboard

type
    Heading* {.size: sizeof(uint32).} = enum
        hUp
        hRight
        hDown
        hLeft

    ButtonBehaviour* {.size: sizeof(uint32).} = enum
        bbDefault
        bbRepeater

    Modify* {.size: sizeof(uint32).} = enum
        mFixed
        mModifiable

    Orientation* {.size: sizeof(uint32).} = enum
        oVertical
        oHorizontal

    CollapseState* {.size: sizeof(uint32).} = enum
        csMinimised
        csMaximised

    ShowState* {.size: sizeof(uint32).} = enum
        ssHidden
        ssShown

    ColourFormat* {.size: sizeof(uint32).} = enum
        cfRgb
        cfRgba

    PopupKind* {.size: sizeof(uint32).} = enum
        pkStatic
        pkDynamic

    LayoutFormat* {.size: sizeof(uint32).} = enum
        lfDynamic
        lfStatic

    SymbolKind* {.size: sizeof(uint32).} = enum
        skNone
        skX
        skUnderscore
        skCircleSolid
        skCircleOutline
        skRectSolid
        skRectOutline
        skTriUp
        skTriDown
        skTriLeft
        skTriRight
        skPlus
        skMinus
        skTriUpOutline
        skTriDownOutline
        skTriLeftOutline
        skTriRightOutline

    AllocationKind* {.size: sizeof(uint32).} = enum
        akFixed
        akDynamic

    BufferAllocationKind* {.size: sizeof(uint32).} = enum
        bakFront
        bakBack
        bakMax

    #[ ---------------------------------------------------------------- ]#

    AntiAliasing* {.size: sizeof(uint32).} = enum
        aaOff
        aaOn

    DrawVertexLayoutAttribute* {.size: sizeof(uint32).} = enum
        dvlaPosition
        dvlaColour
        dvlaTexcoord
        dvlaEnd

    DrawVertexLayoutFormat* {.size: sizeof(uint32).} = enum
        dvlfSchar
        dvlfSshort
        dvlfSint
        dvlfUchar
        dvlfUshort
        dvlfUint
        dvlfFloat
        dvlfDouble

        dvlfR8G8B8
        dvlfR16G15B16
        dvlfR32G32B32
        dvlfR8G8B8A8
        dvlfB8G8R8A8
        dvlfR16G15B16A16
        dvlfR32G32B32A32
        dvlfR32G32B32A32Float
        dvlfR32G32B32A32Double
        dvlfRgb32
        dvlfRgba32

        dvlfEnd

    CommandKind* {.size: sizeof(uint32).} = enum
        ckNop
        ckScissor
        ckLine
        ckCurve
        ckRect
        ckRectFilled
        ckRectMultiColour
        ckCircle
        ckCircleFilled
        ckArc
        ckArcFilled
        ckTriangle
        ckTriangleFilled
        ckPolygon
        ckPolygonFilled
        ckPolyline
        ckText
        ckImage
        ckCustom

    CommandClipping* {.size: sizeof(uint32).} = enum
        ccOff = false
        ccOn  = true

    DrawListStroke* {.size: sizeof(uint32).} = enum
        dlsOpen   = false
        dlsClosed = true

    #[ ---------------------------------------------------------------- ]#

    FontAtlasFormat* {.size: sizeof(uint32).} = enum
        fafAlpha8
        fafRgba32

    FontCoordKind* {.size: sizeof(uint32).} = enum
        fckUv
        fckPixel
    
    #[ ---------------------------------------------------------------- ]#

    KeyKind* {.size: sizeof(uint32).} = enum
        kkNone
        kkShift
        kkCtrl
        kkDel
        kkEnter
        kkTab
        kkBackspace
        kkCopy
        kkCut
        kkPaste
        kkUp
        kkDown
        kkLeft
        kkRight
        kkTextInsertMode
        kkTextReplaceMode
        kkTextResetMode
        kkTextLineStart
        kkTextLineEnd
        kkTextStart
        kkTextEnd
        kkTextUndo
        kkTextRedo
        kkTextSelectAll
        kkTextWordLeft
        kkTextWordRight
        kkScrollStart
        kkScrollEnd
        kkScrollDown
        kkScrollUp

    Button* {.size: sizeof(uint32).} = enum
        bLeft
        bMiddle
        bRight
        bDouble

    #[ ---------------------------------------------------------------- ]#

    WidgetAlignment* {.size: sizeof(uint32).} = enum
        waLeft    = wafMiddle or wafLeft
        waCentred = wafMiddle or wafCentred
        waRight   = wafMiddle or wafRight

    #[ ---------------------------------------------------------------- ]#

    StyleColours* {.size: sizeof(uint32).} = enum
        scText
        scWin
        scHeader
        scBorder
        scBtn
        scBtnHover
        scBtnActive
        scToggle
        scToggleHover
        scToggleCursor
        scSelect
        scSelectActive
        scSlider
        scSliderCursor
        scSliderCursorHover
        scSliderCursorActive
        scProp
        scEdit
        scEditCursor
        scCombo
        scChart
        scChartColour
        scChartColourHighlight
        scScrollbar
        scScrollbarCursor
        scScrollbarCursorHover
        scScrollbarCursorActive
        scTabHeader

    StyleCursor* {.size: sizeof(uint32).} = enum
        scArrow
        scText
        scMove
        scResizeVertical
        scResizeHorizontal
        scResizeTopLeftDownRight
        scResizeTopRightDownLeft

    StyleItemKind* {.size: sizeof(uint32).} = enum
        sikColour
        sikImage
        sikNineSlice

    StyleHeaderAlign* {.size: sizeof(uint32).} = enum
        shaLeft
        shaRight

    #[ ---------------------------------------------------------------- ]#

    TextAlignment* {.size: sizeof(uint32).} = enum
        taLeft    = tafMiddle or tafLeft
        taCentred = tafMiddle or tafCentred
        taRight   = tafMiddle or tafRight

    TextEditKind* {.size: sizeof(uint32).} = enum
        ekSingleLine
        ekMultiline

    TextEditMode* {.size: sizeof(uint32).} = enum
        temView
        temInsert
        temReplace

    #[ ---------------------------------------------------------------- ]#

    TreeKind* {.size: sizeof(uint32).} = enum
        tkNode
        tkTab

    #[ ---------------------------------------------------------------- ]#

    WidgetLayoutState* {.size: sizeof(uint32).} = enum
        wlsInvalid
        wlsValid
        wlsRom
        wlsDisabled

    ChartKind* {.size: sizeof(uint32).} = enum
        ckLine
        ckColumn

    #[ ---------------------------------------------------------------- ]#

    PanelSet* {.size: sizeof(uint32).} = enum
        psNonBlock = PSetNonBlock
        psPopup    = PSetPopup
        psSub      = PSetSub

    PanelRowLayout* {.size: sizeof(uint32).} = enum
        prlDynamicFixed
        prlDynamicRow
        prlDynamicFree
        prlDynamic
        prlStaticFixed
        prlStaticRow
        prlStaticFree
        prlStatic
        prlTemplate

    EditKind* {.size: sizeof(uint32).} = enum
        ekSimple = EKindSimple
        ekField  = EKindField
        ekEditor = EKindEditor
        ekBox    = EKindBox

const FmtColourStart = dvlfR8G8B8
const FmtColourEnd   = dvlfRgba32

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
        r*, g*, b*, a*: cfloat

    Vec2I* = object
        x*, y*: cshort

    Vec2* = object
        x*, y*: cfloat

    RectI* = object
        x*, y*, w*, h*: cshort

    Rect* = object
        x*, y*, w*, h*: cfloat

    Glyph* = array[NkUtfSize, char]

    Handle* {.union.} = object
        p* : pointer
        id*: cint

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

    PluginAlloc*  = proc(handle: Handle; old: pointer; sz: uint): pointer {.cdecl, raises: [].}
    PluginFree*   = proc(handle: Handle; old: pointer)                    {.cdecl, raises: [].}
    PluginFilter* = proc(text_edit: ptr TextEdit; unicode: Rune): bool    {.cdecl, raises: [].}
    PluginPaste*  = proc(handle: Handle; text_edit: ptr TextEdit)         {.cdecl, raises: [].}
    PluginCopy*   = proc(handle: Handle; str: cstring; len: cint)         {.cdecl, raises: [].}

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
        markers*    : array[bakMax, BufferMarker]
        pool*       : Allocator
        kind*       : AllocationKind
        mem*        : Memory
        grow_factor*: cfloat
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
        last_widget_state*: WidgetStateFlag
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

    CommandCustomCallback* = proc(canvas: pointer; x, y: cshort; w, h: cushort; cb_data: Handle) {.cdecl, raises: [].}

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
        buf*        : ptr Buffer
        vertices*   : ptr Buffer
        elems*      : ptr Buffer
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

    TextWidthFn*      = proc(handle: Handle; h: cfloat; text: cstring; len: cint): cfloat                               {.cdecl, raises: [].}
    QueryFontGlyphFn* = proc(handle: Handle; font_h: cfloat; glyph: ptr UserFontGlyph; codepoint, next_codepoint: Rune) {.cdecl, raises: [].}

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
        style_items*   : ConfigStackStyleItem
        floats*        : ConfigStackFloat
        vectors*       : ConfigStackVec2
        flags*         : ConfigStackFlag
        colours*       : ConfigStackColour
        user_fonts*    : ConfigStackUserFont
        btn_behaviours*: ConfigStackButtonBehaviour

    ConfigStackStyleItem* = object
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
        elems*: array[NkUserFontStackSize, tuple[address: ptr ptr UserFont, old_val: ptr UserFont]]
    ConfigStackButtonBehaviour* = object
        head* : cint
        elems*: array[NkButtonBehaviourStackSize, tuple[address: ptr ButtonBehaviour, old_val: ButtonBehaviour]]

    #[ ---------------------------------------------------------------- ]#

    Style* = object
        font*          : ptr UserFont
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
        knob*          : StyleKnob
        progress*      : StyleProgress
        prop*          : StyleProperty
        edit*          : StyleEdit
        chart*         : StyleChart
        scroll_h*      : StyleScrollbar
        scroll_v*      : StyleScrollbar
        tab*           : StyleTab
        combo*         : StyleCombo
        win*           : StyleWindow

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
        draw_begin*: proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}
        draw_end*  : proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}

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
        draw_begin*: proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}
        draw_end*  : proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}

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
        draw_begin*: proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}
        draw_end*  : proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}

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
        draw_begin*: proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}
        draw_end*  : proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}

    StyleKnob* = object
        normal*       : StyleItem
        hover*        : StyleItem
        active*       : StyleItem
        border_colour*: Colour

        knob_normal*       : Colour
        knob_hover*        : Colour
        knob_active*       : Colour
        knob_border_colour*: Colour

        cursor_normal*: Colour
        cursor_hover* : Colour
        cursor_active*: Colour

        border*         : cfloat
        knob_border*    : cfloat
        padding*        : Vec2
        spacing*        : Vec2
        cursor_w*       : cfloat
        colour_factor*  : cfloat
        disabled_factor*: cfloat

        user_data* : Handle
        draw_begin*: proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}
        draw_end*  : proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}

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
        draw_begin*: proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}
        draw_end*  : proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}

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
        draw_begin*: proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}
        draw_end*  : proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}

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
        draw_begin*: proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}
        draw_end*  : proc(buf: ptr CommandBuffer; user_data: Handle) {.cdecl, raises: [].}

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

#[ -------------------------------------------------------------------- ]#

proc nk_free*(ctx: ptr Context)                   {.importc.}
proc nk_buffer_free*(buf: ptr Buffer)             {.importc.}
proc nk_font_atlas_cleanup*(atlas: ptr FontAtlas) {.importc.}

proc `=destroy`*(ctx: Context)     = nk_free ctx.addr
proc `=destroy`*(buf: Buffer)      = nk_buffer_free buf.addr
proc `=destroy`*(atlas: FontAtlas) = nk_font_atlas_cleanup atlas.addr

converter `EditKind -> EditFlag`*(flag: EditKind): EditFlag = cast[EditFlag](flag)

converter panel_flag_to_window_flag*(flag: PanelFlag): WindowFlag = WindowFlag flag
converter window_flag_to_panel_flag*(flag: WindowFlag): PanelFlag = PanelFlag flag

func nk_vec*(x, y: float32): Vec2        = Vec2(x: cfloat x, y: cfloat y)
func nk_vec*(x, y: int16): Vec2I         = Vec2I(x: cshort x, y: cshort y)
func nk_rect*(x, y, w, h: float32): Rect = Rect(x: cfloat x, y: cfloat y, w: cfloat w, h: cfloat h)
func nk_rect*(x, y, w, h: int16): RectI  = RectI(x: cshort x, y: cshort y, w: cshort w, h: cshort h)

func nk_colour*(r, g, b: uint8; a = 255'u8): Colour   = Colour(r: r, g: g, b: b, a: a)
func nk_colour*(rgba: array[4, uint8]): Colour        = Colour(r: rgba[0], g: rgba[1], b: rgba[2], a: rgba[3])
func nk_colour*(rgb: array[3, uint8]): Colour         = Colour(r: rgb[0], g: rgb[1], b: rgb[2], a: 255)
func nk_colour*(r, g, b: float32; a = 1'f32): ColourF = ColourF(r: r, g: g, b: b, a: a)

template nk_rect*(r: typed): Rect = nk_rect(float32 r[0], float32 r[1], float32 r[2], float32 r[3])
