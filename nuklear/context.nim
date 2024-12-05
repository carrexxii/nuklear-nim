import common, window, input, style, text, stack, drawing, font

using ctx: ptr Context

when defined NkIncludeDefaultAllocator:
    proc nk_init_default*(ctx; font: ptr UserFont): bool {.importc: "nk_init_default".}

proc nk_init_fixed*(ctx; mem: pointer; sz: uint; font: ptr UserFont): bool              {.importc: "nk_init_fixed" .}
proc nk_init*(ctx; allocator: ptr Allocator; font: ptr UserFont): bool                  {.importc: "nk_init"       .}
proc nk_init_custom*(ctx; cmds: ptr Buffer; pool: ptr Buffer; font: ptr UserFont): bool {.importc: "nk_init_custom".}
proc nk_clear*(ctx)                                                                     {.importc: "nk_clear"      .}

#[ -------------------------------------------------------------------- ]#

using ctx: var Context

{.push inline.}

proc init*(ctx; font: ptr Font; allocator = NimAllocator): bool {.discardable.} =
    result = nk_init(ctx.addr, allocator.addr, font.handle.addr)
    nk_assert result, &"Failed to initialize Nuklear (font: {cast[uint](font)}; allocator: {allocator})"

proc clear*(ctx) =
    nk_clear ctx.addr

{.pop.}
