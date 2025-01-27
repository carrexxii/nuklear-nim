import std/macros, defines, types
from std/strformat import `&`
export defines, types, `&`

template nk_assert*(cond, body) =
    when not defined NkNoAssert:
        assert cond, body

converter `pointer -> Handle`*(p: pointer): Handle = Handle(p: p)
converter `Handle -> bool`*(h: Handle): bool = h.p != nil

proc nim_alloc(_: Handle; old: pointer; sz: uint): pointer {.cdecl.} =
    old.realloc sz

proc nim_free(_: Handle; old: pointer) {.cdecl.} =
    discard old.realloc 0

let NimAllocator* = Allocator(
    user_data: nil,
    alloc    : nim_alloc,
    free     : nim_free,
)

#[ -------------------------------------------------------------------- ]#

using
    buf : ptr Buffer
    kind: BufferAllocationKind

{.push importc, cdecl.}
when defined NkIncludeDefaultAllocator:
    proc nk_buffer_init_default*(buf)
proc nk_buffer_init*(buf; allocator: ptr Allocator; sz: uint)
proc nk_buffer_init_fixed*(buf; mem: pointer; sz: uint)
proc nk_buffer_info*(status: ptr MemoryStatus; buf)
proc nk_buffer_push*(buf; kind; mem: pointer; sz, align: uint)
proc nk_buffer_mark*(buf; kind)
proc nk_buffer_reset*(buf; kind)
proc nk_buffer_clear*(buf)
proc nk_buffer_memory*(buf): pointer
proc nk_buffer_memory_const*(buf): pointer
proc nk_buffer_total*(buf): uint
{.pop.}

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
