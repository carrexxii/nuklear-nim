import common

using ctx: ptr Context

proc nk_layout_set_min_row_height*(ctx; h: cfloat)          {.importc: "nk_layout_set_min_row_height"  .}
proc nk_layout_reset_min_row_height*(ctx)                   {.importc: "nk_layout_reset_min_row_height".}
proc nk_layout_widget_bounds*(ctx): Rect                    {.importc: "nk_layout_widget_bounds"       .}
proc nk_layout_ratio_from_pixel*(ctx; px_w: cfloat): cfloat {.importc: "nk_layout_ratio_from_pixel"    .}

proc nk_layout_row*(ctx; fmt: LayoutFormat; h: cfloat; cols: cint; ratio: ptr cfloat) {.importc: "nk_layout_row"        .}
proc nk_layout_row_dynamic*(ctx; h: cfloat; cols: cint)                               {.importc: "nk_layout_row_dynamic".}
proc nk_layout_row_static*(ctx; h: cfloat; item_w, cols: cint)                        {.importc: "nk_layout_row_static" .}
proc nk_layout_row_begin*(ctx; fmt: LayoutFormat; h: cfloat; cols: cint)              {.importc: "nk_layout_row_begin"  .}
proc nk_layout_row_push*(ctx; val: cfloat)                                            {.importc: "nk_layout_row_push"   .}
proc nk_layout_row_end*(ctx)                                                          {.importc: "nk_layout_row_end"    .}

proc nk_layout_row_template_begin*(ctx; h: cfloat)             {.importc: "nk_layout_row_template_begin"        .}
proc nk_layout_row_template_push_dynamic*(ctx)                 {.importc: "nk_layout_row_template_push_dynamic" .}
proc nk_layout_row_template_push_variable*(ctx; min_w: cfloat) {.importc: "nk_layout_row_template_push_variable".}
proc nk_layout_row_template_push_static*(ctx; w: cfloat)       {.importc: "nk_layout_row_template_push_static"  .}
proc nk_layout_row_template_end*(ctx)                          {.importc: "nk_layout_row_template_end"          .}

proc nk_layout_space_begin*(ctx; fmt: LayoutFormat; h: cfloat; widget_count: cint) {.importc: "nk_layout_space_begin"         .}
proc nk_layout_space_push*(ctx; bounds: Rect)                                      {.importc: "nk_layout_space_push"          .}
proc nk_layout_space_end*(ctx)                                                     {.importc: "nk_layout_space_end"           .}
proc nk_layout_space_bounds*(ctx): Rect                                            {.importc: "nk_layout_space_bounds"        .}
proc nk_layout_space_to_screen*(ctx; pos: Vec2): Vec2                              {.importc: "nk_layout_space_to_screen"     .}
proc nk_layout_space_to_local*(ctx; pos: Vec2): Vec2                               {.importc: "nk_layout_space_to_local"      .}
proc nk_layout_space_rect_to_screen*(ctx; rect: Rect): Rect                        {.importc: "nk_layout_space_rect_to_screen".}
proc nk_layout_space_rect_to_local*(ctx; rect: Rect): Rect                         {.importc: "nk_layout_space_rect_to_local" .}

proc nk_spacer*(ctx) {.importc: "nk_spacer".}
