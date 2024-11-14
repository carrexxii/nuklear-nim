import common, window, input, style, text, stack, drawing, font

const NkValuePageCapacity* = max(sizeof Window, sizeof Panel) div (sizeof cuint) div 2

type
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

#[ -------------------------------------------------------------------- ]#

using ctx: ptr Context

when defined NkIncludeDefaultAllocator:
    proc nk_init_default*(ctx; font: ptr UserFont): bool {.importc: "nk_init_default".}

proc nk_init_fixed*(ctx; mem: pointer; sz: uint; font: ptr UserFont): bool              {.importc: "nk_init_fixed" .}
proc nk_init*(ctx; allocator: ptr Allocator; font: ptr UserFont): bool                  {.importc: "nk_init"       .}
proc nk_init_custom*(ctx; cmds: ptr Buffer; pool: ptr Buffer; font: ptr UserFont): bool {.importc: "nk_init_custom".}
proc nk_clear*(ctx)                                                                     {.importc: "nk_clear"      .}
proc nk_free*(ctx)                                                                      {.importc: "nk_free"       .}
