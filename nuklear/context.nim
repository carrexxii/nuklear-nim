import common, window, input, style, text, stack, drawing, font

using ctx: ptr Context

{.push importc, cdecl.}
when defined NkIncludeDefaultAllocator:
    proc nk_init_default*(ctx; font: ptr UserFont): bool

proc nk_init_fixed*(ctx; mem: pointer; sz: uint; font: ptr UserFont): bool
proc nk_init*(ctx; allocator: ptr Allocator; font: ptr UserFont): bool
proc nk_init_custom*(ctx; cmds: ptr Buffer; pool: ptr Buffer; font: ptr UserFont): bool
proc nk_clear*(ctx)
{.pop.}

#[ -------------------------------------------------------------------- ]#

using ctx: var Context

{.push inline.}

proc init*(ctx; font: ptr Font; allocator = NimAllocator): bool {.discardable.} =
    result = nk_init(ctx.addr, allocator.addr, font.handle.addr)
    nk_assert result, &"Failed to initialize Nuklear (font: {cast[uint](font)}; allocator: {allocator})"

proc clear*(ctx) =
    nk_clear ctx.addr

{.pop.}
