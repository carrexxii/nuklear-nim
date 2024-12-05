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

#[ -------------------------------------------------------------------- ]#

using ctx: var Context

{.push inline.}

proc `min_row_height=`*(ctx; h: float32) = nk_layout_set_min_row_height ctx.addr, cfloat h

proc reset_min_row_height*(ctx) = nk_layout_reset_min_row_height ctx.addr

proc bounds*(ctx): Rect = nk_layout_widget_bounds ctx.addr

proc begin*(ctx; fmt: LayoutFormat; cols: SomeInteger; h: SomeNumber) =
    nk_layout_row_begin ctx.addr, fmt, cfloat h, cint cols

proc end_row*(ctx) = 
    nk_layout_row_end ctx.addr

proc row*(ctx; cols: SomeInteger; h: SomeNumber; item_w: SomeNumber) = nk_layout_row_static  ctx.addr, cfloat h, cint item_w, cint cols
proc row*(ctx; cols: SomeInteger; h: SomeNumber)                     = nk_layout_row_dynamic ctx.addr, cfloat h, cint cols

proc push*(ctx; val: SomeNumber) =
    nk_layout_row_push ctx.addr, cfloat val

template row_static*(ctx; cols: SomeInteger; h: SomeNumber; item_w: SomeNumber; body: untyped) = 
    row ctx, cols, h, item_w
    with ctx:
        body
template row_dynamic*(ctx; cols: SomeInteger; h: SomeNumber; body: untyped) = 
    row ctx, cols, h
    with ctx:
        body
template row_custom*(ctx: var Context; cols: SomeInteger; h: SomeNumber; body: untyped) =
    with ctx:
        begin lfStatic, cols, h
        body
        end_row

# proc nk_layout_row*(ctx; fmt: LayoutFormat; h: cfloat; cols: cint; ratio: ptr cfloat) {.importc: "nk_layout_row"        .}
# proc nk_layout_row_dynamic*(ctx; h: cfloat; cols: cint)                               {.importc: "nk_layout_row_dynamic".}
# proc nk_layout_row_static*(ctx; h: cfloat; item_w, cols: cint)                        {.importc: "nk_layout_row_static" .}
# proc nk_layout_row_begin*(ctx; fmt: LayoutFormat; h: cfloat; cols: cint)              {.importc: "nk_layout_row_begin"  .}
# proc nk_layout_row_push*(ctx; val: cfloat)                                            {.importc: "nk_layout_row_push"   .}
# proc nk_layout_row_end*(ctx)                                                          {.importc: "nk_layout_row_end"    .}

# proc nk_layout_row_template_begin*(ctx; h: cfloat)             {.importc: "nk_layout_row_template_begin"        .}
# proc nk_layout_row_template_push_dynamic*(ctx)                 {.importc: "nk_layout_row_template_push_dynamic" .}
# proc nk_layout_row_template_push_variable*(ctx; min_w: cfloat) {.importc: "nk_layout_row_template_push_variable".}
# proc nk_layout_row_template_push_static*(ctx; w: cfloat)       {.importc: "nk_layout_row_template_push_static"  .}
# proc nk_layout_row_template_end*(ctx)                          {.importc: "nk_layout_row_template_end"          .}

# proc nk_layout_space_begin*(ctx; fmt: LayoutFormat; h: cfloat; widget_count: cint) {.importc: "nk_layout_space_begin"         .}
# proc nk_layout_space_push*(ctx; bounds: Rect)                                      {.importc: "nk_layout_space_push"          .}
# proc nk_layout_space_end*(ctx)                                                     {.importc: "nk_layout_space_end"           .}
# proc nk_layout_space_bounds*(ctx): Rect                                            {.importc: "nk_layout_space_bounds"        .}
# proc nk_layout_space_to_screen*(ctx; pos: Vec2): Vec2                              {.importc: "nk_layout_space_to_screen"     .}
# proc nk_layout_space_to_local*(ctx; pos: Vec2): Vec2                               {.importc: "nk_layout_space_to_local"      .}
# proc nk_layout_space_rect_to_screen*(ctx; rect: Rect): Rect                        {.importc: "nk_layout_space_rect_to_screen".}
# proc nk_layout_space_rect_to_local*(ctx; rect: Rect): Rect                         {.importc: "nk_layout_space_rect_to_local" .}

# proc nk_spacer*(ctx) {.importc: "nk_spacer".}

{.pop.}
