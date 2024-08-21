import common, window

const NkValuePageCapacity* = max(sizeof NkWindow, sizeof NkPanel) div (sizeof uint32) div 2

type
    NkInput               = object
    NkStyle               = object
    NkClipboard           = object
    NkButtonBehaviour     = object
    NkConfigurationStacks = object
    NkTextEdit            = object
    # NkWindow              = object
    NkCommandBuffer       = object

type
    NkContext* = object
        input*            : NkInput
        style*            : NkStyle
        mem*              : NkBuffer
        clip*             : NkClipboard
        last_widget_state*: NkFlag
        btn_behaviour*    : NkButtonBehaviour
        stacks*           : NkConfigurationStacks
        dt_secs*          : float32
        when defined NkIncludeVertexBufferOutput:
            draw_lst: NkDrawList
        when defined NkIncludeCommandUserData:
            user_data: NkHandle
        txt_edit: NkTextEdit
        overlay : NkCommandBuffer
        build   : int32
        use_pool: int32
        pool    : NkPool
        begin   : ptr NkWindow
        `end`   : ptr NkWindow
        active  : ptr NkWindow
        current : ptr NkWindow
        free_lst: ptr NkPageElement
        count   : uint32
        `seq`   : uint32

    NkTable = object
        `seq`: uint32
        sz   : uint32
        keys : array[NkValuePageCapacity, NkHash]
        vals : array[NkValuePageCapacity, uint32]
        next : ptr NkTable
        prev : ptr NkTable

    NkPageData {.union.} = object
        tbl: NkTable
        pan: NkPanel
        win: NkWindow

    NkPageElement = object
        data: NkPageData
        next: ptr NkPageElement
        prev: ptr NkPageElement

    NkPage = object
        sz  : uint32
        next: ptr NkPage
        win : array[1, NkPageElement]

    NkPool = object
        alloc     : NkAllocator
        kind      : NkAllocationKind
        page_count: uint32
        pages     : ptr UncheckedArray[NkPage]
        free_lst  : ptr UncheckedArray[NkPageElement]
        capacity  : uint32
        sz        : uint
        cap       : uint
