import bitgen, common

using
    ctx    : ptr Context
    cmd_buf: ptr CommandBuffer
    canvas : ptr DrawList
    colour : Colour
    rect   : Rect
    aa     : AntiAliasing

proc nk_begin*(ctx): ptr Command                  {.importc: "nk__begin".}
proc nk_next*(ctx; cmd: ptr Command): ptr Command {.importc: "nk__next" .}
when defined NkIncludeVertexBufferOutput:
    proc nk_convert*(ctx; cmds, verts, elems: ptr Buffer; cfg: ptr ConvertConfig): ConvertResult {.importc: "nk_convert"    .}
    proc nk_draw_begin*(ctx; cmds: ptr Buffer): ptr DrawCommand                                  {.importc: "nk__draw_begin".}
    proc nk_draw_end*(ctx; cmds: ptr Buffer): ptr DrawCommand                                    {.importc: "nk__draw_end"  .}
    proc nk_draw_next*(cmd: ptr DrawCommand; cmds: ptr Buffer; ctx): ptr DrawCommand             {.importc: "nk__draw_next" .}

proc nk_stroke_line*(cmd_buf; x0, y0, x1, y1, thickness: cfloat; colour)                      {.importc: "nk_stroke_line"    .}
proc nk_stroke_curve*(cmd_buf; x0, y0, x1, y1, ctrl1, ctrl2, thickness: cfloat; colour)       {.importc: "nk_stroke_curve"   .}
proc nk_stroke_rect*(cmd_buf; rect; rounding, thickness: cfloat; colour)                      {.importc: "nk_stroke_rect"    .}
proc nk_stroke_circle*(cmd_buf; rect; thickness: cfloat; colour)                              {.importc: "nk_stroke_circle"  .}
proc nk_stroke_arc*(cmd_buf; cx, cy, r, a_min, a_max, thickness: cfloat; colour)              {.importc: "nk_stroke_arc"     .}
proc nk_stroke_triangle*(cmd_buf; x0, y0, x1, y1, x2, y2, thickness: cfloat; colour)          {.importc: "nk_stroke_triangle".}
proc nk_stroke_polyline*(cmd_buf; pts: ptr cfloat; pt_count: cint; thickness: cfloat; colour) {.importc: "nk_stroke_polyline".}
proc nk_stroke_polygon*(cmd_buf; pts: ptr cfloat; pt_count: cint; thickness: cfloat; colour)  {.importc: "nk_stroke_polygon" .}

proc nk_fill_rect*(cmd_buf; rect; rounding: cfloat; colour)                     {.importc: "nk_fill_rect"            .}
proc nk_fill_rect_multi_color*(cmd_buf; rect; left, top, right, bottom: Colour) {.importc: "nk_fill_rect_multi_color".}
proc nk_fill_circle*(cmd_buf; rect; colour)                                     {.importc: "nk_fill_circle"          .}
proc nk_fill_arc*(cmd_buf; cx, cy, r, a_min, a_max: cfloat; colour)             {.importc: "nk_fill_arc"             .}
proc nk_fill_triangle*(cmd_buf; x0, y0, x1, y1, x2, y2: cfloat; colour)         {.importc: "nk_fill_triangle"        .}
proc nk_fill_polygon*(cmd_buf; pts: ptr cfloat; pt_count: cint; colour)         {.importc: "nk_fill_polygon"         .}

proc nk_draw_image*(cmd_buf; rect; img: ptr Image; colour)                                      {.importc: "nk_draw_image"     .}
proc nk_draw_nine_slice*(cmd_buf; rect; ns: ptr NineSlice; colour)                              {.importc: "nk_draw_nine_slice".}
proc nk_draw_text*(cmd_buf; rect; text: cstring; len: cint; font: ptr UserFont; bg, fg: Colour) {.importc: "nk_draw_text"      .}
proc nk_push_scissor*(cmd_buf; rect)                                                            {.importc: "nk_push_scissor"   .}
proc nk_push_custom*(cmd_buf; rect: CommandCustomCallback; cb_data: Handle)                     {.importc: "nk_push_custom"    .}

proc nk_draw_list_init*(canvas)                                                                                           {.importc: "nk_draw_list_init" .}
proc nk_draw_list_setup*(canvas; cfg: ptr ConvertConfig; cmds, verts, elems: ptr Buffer; line_aa, shape_aa: AntiAliasing) {.importc: "nk_draw_list_setup".}

proc nk_draw_list_begin*(canvas; buf: ptr Buffer): ptr DrawCommand                      {.importc: "nk__draw_list_begin".}
proc nk_draw_list_next*(cmd: ptr DrawCommand; buf: ptr Buffer; canvas): ptr DrawCommand {.importc: "nk__draw_list_next" .}
proc nk_draw_list_end*(canvas; buf: ptr Buffer): ptr DrawCommand                        {.importc: "nk__draw_list_end"  .}

proc nk_draw_list_path_clear*(canvas)                                                          {. importc: "nk_draw_list_path_clear"      .}
proc nk_draw_list_path_line_to*(canvas; pos: Vec2)                                             {. importc: "nk_draw_list_path_line_to"    .}
proc nk_draw_list_path_arc_to_fast*(canvas; centre: Vec2; r: cfloat; a_min, a_max: cint)       {. importc: "nk_draw_list_path_arc_to_fast".}
proc nk_draw_list_path_arc_to*(canvas; centre: Vec2; r, a_min, a_max: cfloat; segments: cuint) {. importc: "nk_draw_list_path_arc_to"     .}
proc nk_draw_list_path_rect_to*(canvas; a, b: Vec2; rounding: cfloat)                          {. importc: "nk_draw_list_path_rect_to"    .}
proc nk_draw_list_path_curve_to*(canvas; p2, p3, p4: Vec2; segments: cuint)                    {. importc: "nk_draw_list_path_curve_to"   .}
proc nk_draw_list_path_fill*(canvas; colour)                                                   {. importc: "nk_draw_list_path_fill"       .}
proc nk_draw_list_path_stroke*(canvas; colour; closed: DrawListStroke; thickness: cfloat)      {. importc: "nk_draw_list_path_stroke"     .}

proc nk_draw_list_stroke_line*(canvas; a, b: Vec2; colour; thickness: cfloat)                                                      {.importc: "nk_draw_list_stroke_line"     .}
proc nk_draw_list_stroke_rect*(canvas; rect; colour; rounding, thickness: cfloat)                                                  {.importc: "nk_draw_list_stroke_rect"     .}
proc nk_draw_list_stroke_triangle*(canvas; a, b, c: Vec2; colour; thickness: cfloat)                                               {.importc: "nk_draw_list_stroke_triangle" .}
proc nk_draw_list_stroke_circle*(canvas; centre: Vec2; r: cfloat; colour; segments: cuint; thickness: cfloat)                      {.importc: "nk_draw_list_stroke_circle"   .}
proc nk_draw_list_stroke_curve*(canvas; p0, cp0, cp1, p1: Vec2; colour; segments: cuint; thickness: cfloat)                        {.importc: "nk_draw_list_stroke_curve"    .}
proc nk_draw_list_stroke_poly_line*(canvas; pts: ptr Vec2; pt_count: cuint; colour; closed: DrawListStroke; thickness: cfloat; aa) {.importc: "nk_draw_list_stroke_poly_line".}

proc nk_draw_list_fill_rect*(canvas; rect; colour; rounding: cfloat)                     {.importc: "nk_draw_list_fill_rect"            .}
proc nk_draw_list_fill_rect_multi_color*(canvas; rect; left, top, right, bottom: Colour) {.importc: "nk_draw_list_fill_rect_multi_color".}
proc nk_draw_list_fill_triangle*(canvas; a, b, c: Vec2; colour)                          {.importc: "nk_draw_list_fill_triangle"        .}
proc nk_draw_list_fill_circle*(canvas; centre: Vec2; r: cfloat; colour; segments: cuint) {.importc: "nk_draw_list_fill_circle"          .}
proc nk_draw_list_fill_poly_convex*(canvas; pts: ptr Vec2; pt_count: cuint; colour; aa)  {.importc: "nk_draw_list_fill_poly_convex"     .}

proc nk_draw_list_add_image*(canvas; img: Image; rect; colour)                                                   {.importc: "nk_draw_list_add_image".}
proc nk_draw_list_add_text*(canvas; font: ptr UserFont; rect; text: cstring; len: cint; font_h: cfloat; colour)  {.importc: "nk_draw_list_add_text" .}
when defined NkIncludeCommandUserData:
    proc nk_draw_list_push_userdata*(canvas; user_data: Handle) {.importc: "nk_draw_list_push_userdata".}

#[ -------------------------------------------------------------------- ]#

using ctx: Context

{.push inline.}

iterator commands*(ctx): Command =
    var cmd = nk_begin ctx.addr
    while cmd != nil:
        yield cmd[]
        cmd = ctx.addr.nk_next cmd

iterator commands*(ctx; cmds: Buffer): DrawCommand =
    var cmd = ctx.addr.nk_draw_begin cmds.addr
    while cmd != nil:
        yield cmd[]
        cmd = cmd.nk_draw_next(cmds.addr, ctx.addr)
    discard ctx.addr.nk_draw_end cmds.addr

proc create_vertex_layout*(elems: varargs[tuple[attr: DrawVertexLayoutAttribute; fmt: DrawVertexLayoutFormat; offset: int]]): seq[DrawVertexLayoutElement] =
    result = new_seq_of_cap[DrawVertexLayoutElement] (elems.len + 1)
    for elem in elems:
        result.add DrawVertexLayoutElement(attr: elem.attr, fmt: elem.fmt, offset: uint elem.offset)
    result.add DrawVertexLayoutElement(attr: dvlaEnd, fmt: dvlfEnd, offset: 0)

proc convert*(ctx; cfg: ConvertConfig; cmds, vtxs, idxs: Buffer): ConvertResult {.discardable.} =
    result = ctx.addr.nk_convert(cmds.addr, vtxs.addr, idxs.addr, cfg.addr)
    nk_assert result == convertSuccess, &"""Failed to convert commands to buffers: \n\t{result}\nConfig: {cfg}\n
                                            Commands = {cmds}; Vertices = {vtxs}; Indices = {idxs}"""

{.pop.}
