import std/macros, defines, types
from std/strformat import `&`
export defines, types, `&`

template nk_assert*(cond, body) =
    when not defined NkNoAssert:
        assert cond, body

converter `pointer -> Handle`*(p: pointer): Handle = result.p = p
converter `Handle -> bool`*(h: Handle): bool = h.p != nil

proc nim_alloc(_: Handle; old: pointer; sz: uint): pointer {.cdecl.} =
    old.realloc sz

proc nim_free(_: Handle; old: pointer) {.cdecl.} =
    discard old.realloc 0

const NimAllocator* = Allocator(
    user_data: nil,
    alloc    : nim_alloc,
    free     : nim_free,
)

#[ -------------------------------------------------------------------- ]#

using
    buf : ptr Buffer
    kind: BufferAllocationKind

when defined NkIncludeDefaultAllocator:
    proc nk_buffer_init_default*(buf) {.importc: "nk_buffer_init_default".}
proc nk_buffer_init*(buf; allocator: ptr Allocator; sz: uint)  {.importc: "nk_buffer_init"        .}
proc nk_buffer_init_fixed*(buf; mem: pointer; sz: uint)        {.importc: "nk_buffer_init_fixed"  .}
proc nk_buffer_info*(status: ptr MemoryStatus; buf)            {.importc: "nk_buffer_info"        .}
proc nk_buffer_push*(buf; kind; mem: pointer; sz, align: uint) {.importc: "nk_buffer_push"        .}
proc nk_buffer_mark*(buf; kind)                                {.importc: "nk_buffer_mark"        .}
proc nk_buffer_reset*(buf; kind)                               {.importc: "nk_buffer_reset"       .}
proc nk_buffer_clear*(buf)                                     {.importc: "nk_buffer_clear"       .}
proc nk_buffer_memory*(buf): pointer                           {.importc: "nk_buffer_memory"      .}
proc nk_buffer_memory_const*(buf): pointer                     {.importc: "nk_buffer_memory_const".}
proc nk_buffer_total*(buf): uint                               {.importc: "nk_buffer_total"       .}

#[ -------------------------------------------------------------------- ]#

{.push inline.}

using
    buf : var Buffer
    kind: BufferAllocationKind

proc create_buffer*(sz: SomeInteger): Buffer =
    nk_buffer_init result.addr, NimAllocator.addr, uint sz

proc reset*(buf; kind)  = nk_buffer_reset  buf.addr, kind
proc mem*(buf): pointer = nk_buffer_memory buf.addr
proc total*(buf): uint  = nk_buffer_total  buf.addr

macro clear*(bufs: varargs[var Buffer]): untyped =
    result = new_stmt_list()
    for buf in bufs:
        result.add quote do:
            nk_buffer_clear `buf`.addr

{.pop.}
