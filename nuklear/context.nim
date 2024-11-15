import common, window, input, style, text, stack, drawing, font

using ctx: ptr Context

when defined NkIncludeDefaultAllocator:
    proc nk_init_default*(ctx; font: ptr UserFont): bool {.importc: "nk_init_default".}

proc nk_init_fixed*(ctx; mem: pointer; sz: uint; font: ptr UserFont): bool              {.importc: "nk_init_fixed" .}
proc nk_init*(ctx; allocator: ptr Allocator; font: ptr UserFont): bool                  {.importc: "nk_init"       .}
proc nk_init_custom*(ctx; cmds: ptr Buffer; pool: ptr Buffer; font: ptr UserFont): bool {.importc: "nk_init_custom".}
proc nk_clear*(ctx)                                                                     {.importc: "nk_clear"      .}
proc nk_free*(ctx)                                                                      {.importc: "nk_free"       .}
