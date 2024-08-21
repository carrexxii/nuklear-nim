import common

type
    NkWidgetAlign* {.size: sizeof(NkFlag).} = enum
        nkAlignLeft    = 0x01
        nkAlignCentred = 0x02
        nkAlignRight   = 0x04
        nkAlignTop     = 0x08
        nkAlignMiddle  = 0x10
        nkAlignBottom  = 0x20

    NkWidgetAlignment* {.size: sizeof(NkFlag).} = enum A, B
    # NkWidgetAlignment* {.size: sizeof(cint).} = enum
        # nkWidgetLeft    = nkAlignMiddle or nkAlignLeft
        # nkWidgetCentred = nkAlignMiddle or nkAlignCentred
        # nkWidgetRight   = nkAlignMiddle or nkAlignRight

using ctx: pointer

proc nk_layout_set_min_row_height*(ctx; h: float32)           {.importc: "nk_layout_set_min_row_height"  .}
proc nk_layout_reset_min_row_height*(ctx)                     {.importc: "nk_layout_reset_min_row_height".}
proc nk_layout_widget_bounds*(ctx): NkRect                    {.importc: "nk_layout_widget_bounds"       .}
proc nk_layout_ratio_from_pixel*(ctx; px_w: float32): float32 {.importc: "nk_layout_ratio_from_pixel"    .}

proc nk_layout_row*(ctx; fmt: NkLayoutFormat; h: float32; cols: int32; ratio: ptr float32) {.importc: "nk_layout_row"        .}
proc nk_layout_row_dynamic*(ctx; h: float32; cols: int32)                                  {.importc: "nk_layout_row_dynamic".}
proc nk_layout_row_static*(ctx; h: float32; item_w, cols: int32)                           {.importc: "nk_layout_row_static" .}
proc nk_layout_row_begin*(ctx; fmt: NkLayoutFormat; h: float32; cols: int32)               {.importc: "nk_layout_row_begin"  .}
proc nk_layout_row_push*(ctx; val: float32)                                                {.importc: "nk_layout_row_push"   .}
proc nk_layout_row_end*(ctx)                                                               {.importc: "nk_layout_row_end"    .}

proc nk_layout_row_template_begin*(ctx; h: float32)             {.importc: "nk_layout_row_template_begin"        .}
proc nk_layout_row_template_push_dynamic*(ctx)                  {.importc: "nk_layout_row_template_push_dynamic" .}
proc nk_layout_row_template_push_variable*(ctx; min_w: float32) {.importc: "nk_layout_row_template_push_variable".}
proc nk_layout_row_template_push_static*(ctx; w: float32)       {.importc: "nk_layout_row_template_push_static"  .}
proc nk_layout_row_template_end*(ctx)                           {.importc: "nk_layout_row_template_end"          .}

proc nk_layout_space_begin*(ctx; fmt: NkLayoutFormat; h: float32; widget_count: int32) {.importc: "nk_layout_space_begin"         .}
proc nk_layout_space_push*(ctx; bounds: NkRect)                                        {.importc: "nk_layout_space_push"          .}
proc nk_layout_space_end*(ctx)                                                         {.importc: "nk_layout_space_end"           .}
proc nk_layout_space_bounds*(ctx): NkRect                                              {.importc: "nk_layout_space_bounds"        .}
proc nk_layout_space_to_screen*(ctx; pos: NkVec2): NkVec2                              {.importc: "nk_layout_space_to_screen"     .}
proc nk_layout_space_to_local*(ctx; pos: NkVec2): NkVec2                               {.importc: "nk_layout_space_to_local"      .}
proc nk_layout_space_rect_to_screen*(ctx; rect: NkRect): NkRect                        {.importc: "nk_layout_space_rect_to_screen".}
proc nk_layout_space_rect_to_local*(ctx; rect: NkRect): NkRect                         {.importc: "nk_layout_space_rect_to_local" .}

proc nk_spacer*(ctx) {.importc: "nk_spacer".}
