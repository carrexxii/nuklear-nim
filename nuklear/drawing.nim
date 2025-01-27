import bitgen, common

using
    ctx    : ptr Context
    cmd_buf: ptr CommandBuffer
    canvas : ptr DrawList
    colour : Colour
    rect   : Rect
    aa     : AntiAliasing

proc nk_begin*(ctx): ptr Command                  {.importc: "nk__begin", cdecl.}
proc nk_next*(ctx; cmd: ptr Command): ptr Command {.importc: "nk__next" , cdecl.}
when defined NkIncludeVertexBufferOutput:
    proc nk_convert*(ctx; cmds, verts, elems: ptr Buffer; cfg: ptr ConvertConfig): ConvertResultFlag {.importc: "nk_convert"    , cdecl.}
    proc nk_draw_begin*(ctx; cmds: ptr Buffer): ptr DrawCommand                                      {.importc: "nk__draw_begin", cdecl.}
    proc nk_draw_end*(ctx; cmds: ptr Buffer): ptr DrawCommand                                        {.importc: "nk__draw_end"  , cdecl.}
    proc nk_draw_next*(cmd: ptr DrawCommand; cmds: ptr Buffer; ctx): ptr DrawCommand                 {.importc: "nk__draw_next" , cdecl.}

{.push importc, cdecl.}
proc nk_stroke_line*(cmd_buf; x0, y0, x1, y1, thickness: cfloat; colour)
proc nk_stroke_curve*(cmd_buf; x0, y0, x1, y1, ctrl1, ctrl2, thickness: cfloat; colour)
proc nk_stroke_rect*(cmd_buf; rect; rounding, thickness: cfloat; colour)
proc nk_stroke_circle*(cmd_buf; rect; thickness: cfloat; colour)
proc nk_stroke_arc*(cmd_buf; cx, cy, r, a_min, a_max, thickness: cfloat; colour)
proc nk_stroke_triangle*(cmd_buf; x0, y0, x1, y1, x2, y2, thickness: cfloat; colour)
proc nk_stroke_polyline*(cmd_buf; pts: ptr cfloat; pt_count: cint; thickness: cfloat; colour)
proc nk_stroke_polygon*(cmd_buf; pts: ptr cfloat; pt_count: cint; thickness: cfloat; colour)

proc nk_fill_rect*(cmd_buf; rect; rounding: cfloat; colour)
proc nk_fill_rect_multi_color*(cmd_buf; rect; left, top, right, bottom: Colour)
proc nk_fill_circle*(cmd_buf; rect; colour)
proc nk_fill_arc*(cmd_buf; cx, cy, r, a_min, a_max: cfloat; colour)
proc nk_fill_triangle*(cmd_buf; x0, y0, x1, y1, x2, y2: cfloat; colour)
proc nk_fill_polygon*(cmd_buf; pts: ptr cfloat; pt_count: cint; colour)

proc nk_draw_image*(cmd_buf; rect; img: ptr Image; colour)
proc nk_draw_nine_slice*(cmd_buf; rect; ns: ptr NineSlice; colour)
proc nk_draw_text*(cmd_buf; rect; text: cstring; len: cint; font: ptr UserFont; bg, fg: Colour)
proc nk_push_scissor*(cmd_buf; rect)
proc nk_push_custom*(cmd_buf; rect: CommandCustomCallback; cb_data: Handle)

proc nk_draw_list_init*(canvas)
proc nk_draw_list_setup*(canvas; cfg: ptr ConvertConfig; cmds, verts, elems: ptr Buffer; line_aa, shape_aa: AntiAliasing)

{.pop.}
proc nk_draw_list_begin*(canvas; buf: ptr Buffer): ptr DrawCommand                      {.importc: "nk__draw_list_begin".}
proc nk_draw_list_next*(cmd: ptr DrawCommand; buf: ptr Buffer; canvas): ptr DrawCommand {.importc: "nk__draw_list_next" .}
proc nk_draw_list_end*(canvas; buf: ptr Buffer): ptr DrawCommand                        {.importc: "nk__draw_list_end"  .}

{.push importc.}
proc nk_draw_list_path_clear*(canvas)
proc nk_draw_list_path_line_to*(canvas; pos: Vec2)
proc nk_draw_list_path_arc_to_fast*(canvas; centre: Vec2; r: cfloat; a_min, a_max: cint)
proc nk_draw_list_path_arc_to*(canvas; centre: Vec2; r, a_min, a_max: cfloat; segments: cuint)
proc nk_draw_list_path_rect_to*(canvas; a, b: Vec2; rounding: cfloat)
proc nk_draw_list_path_curve_to*(canvas; p2, p3, p4: Vec2; segments: cuint)
proc nk_draw_list_path_fill*(canvas; colour)
proc nk_draw_list_path_stroke*(canvas; colour; closed: DrawListStroke; thickness: cfloat)

proc nk_draw_list_stroke_line*(canvas; a, b: Vec2; colour; thickness: cfloat)
proc nk_draw_list_stroke_rect*(canvas; rect; colour; rounding, thickness: cfloat)
proc nk_draw_list_stroke_triangle*(canvas; a, b, c: Vec2; colour; thickness: cfloat)
proc nk_draw_list_stroke_circle*(canvas; centre: Vec2; r: cfloat; colour; segments: cuint; thickness: cfloat)
proc nk_draw_list_stroke_curve*(canvas; p0, cp0, cp1, p1: Vec2; colour; segments: cuint; thickness: cfloat)
proc nk_draw_list_stroke_poly_line*(canvas; pts: ptr Vec2; pt_count: cuint; colour; closed: DrawListStroke; thickness: cfloat; aa)

proc nk_draw_list_fill_rect*(canvas; rect; colour; rounding: cfloat)
proc nk_draw_list_fill_rect_multi_color*(canvas; rect; left, top, right, bottom: Colour)
proc nk_draw_list_fill_triangle*(canvas; a, b, c: Vec2; colour)
proc nk_draw_list_fill_circle*(canvas; centre: Vec2; r: cfloat; colour; segments: cuint)
proc nk_draw_list_fill_poly_convex*(canvas; pts: ptr Vec2; pt_count: cuint; colour; aa)

proc nk_draw_list_add_image*(canvas; img: Image; rect; colour)
proc nk_draw_list_add_text*(canvas; font: ptr UserFont; rect; text: cstring; len: cint; font_h: cfloat; colour)
when defined NkIncludeCommandUserData:
    proc nk_draw_list_push_userdata*(canvas; user_data: Handle)
{.pop.}

#[ -------------------------------------------------------------------- ]#

using ctx: var Context

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

proc convert*(ctx; cfg: ConvertConfig; cmds, vtxs, idxs: Buffer): ConvertResultFlag {.discardable.} =
    result = ctx.addr.nk_convert(cmds.addr, vtxs.addr, idxs.addr, cfg.addr)
    nk_assert result == crfSuccess, &"""Failed to convert commands to buffers: \n\t{result}\nConfig: {cfg}\n
                                        Commands = {repr cmds}; Vertices = {repr vtxs}; Indices = {repr idxs}"""

{.pop.}
