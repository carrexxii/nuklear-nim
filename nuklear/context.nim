import common, window, input, style, text, stack, drawing, font

const NkValuePageCapacity* = max(sizeof NkWindow, sizeof NkPanel) div (sizeof uint32) div 2

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
        text_edit: NkTextEdit
        overlay  : NkCommandBuffer
        build    : int32
        use_pool : int32
        pool     : NkPool
        begin    : ptr NkWindow
        `end`    : ptr NkWindow
        active   : ptr NkWindow
        current  : ptr NkWindow
        free_lst : ptr NkPageElement
        count    : uint32
        `seq`    : uint32

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

using ctx: ptr NkContext

when defined NkIncludeDefaultAllocator:
    {.passC: "-DNK_INCLUDE_DEFAULT_ALLOCATOR".}
    proc nk_init_default*(ctx; font: ptr NkUserFont): bool {.importc: "nk_init_default".}

proc nk_init_fixed*(ctx; mem: pointer; sz: uint; font: ptr NkUserFont): bool                  {.importc: "nk_init_fixed" .}
proc nk_init*(ctx; allocator: ptr NkAllocator; font: ptr NkUserFont): bool                    {.importc: "nk_init"       .}
proc nk_init_custom*(ctx; cmds: ptr NkBuffer; pool: ptr NkBuffer; font: ptr NkUserFont): bool {.importc: "nk_init_custom".}
proc nk_clear*(ctx)                                                                           {.importc: "nk_clear"      .}
proc nk_free*(ctx)                                                                            {.importc: "nk_free"       .}
