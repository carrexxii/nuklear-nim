import bitgen, common
from font import UserFont

type ConvertResult* = distinct uint32
ConvertResult.gen_bit_ops convertInvalidParam, convertCmdBufFull, convertVtxBufFull, convertElemBufFull
const convertSuccess* = ConvertResult 0

type
    AntiAliasing* {.size: sizeof(Flag).} = enum
        aaOff
        aaOn

    DrawVertexLayoutAttribute* {.size: sizeof(Flag).} = enum
        vtxPosition
        vtxColour
        vtxTexcoord

    DrawVertexLayoutFormat* {.size: sizeof(Flag).} = enum
        fmtSchar
        fmtSshort
        fmtSint
        fmtUchar
        fmtUshort
        fmtUint
        fmtFloat
        fmtDouble

        fmtR8G8B8
        fmtR16G15B16
        fmtR32G32B32
        fmtR8G8B8A8
        fmtB8G8R8A8
        fmtR16G15B16A16
        fmtR32G32B32A32
        fmtR32G32B32A32Float
        fmtR32G32B32A32Double
        fmtRgb32
        fmtRgba32

    CommandKind* {.size: sizeof(Flag).} = enum
        cmdNop
        cmdScissor
        cmdLine
        cmdCurve
        cmdRect
        cmdRectFilled
        cmdRectMultiColour
        cmdCircle
        cmdCircleFilled
        cmdArc
        cmdArcFilled
        cmdTriangle
        cmdTriangleFilled
        cmdPolygon
        cmdPolygonFilled
        cmdPolyline
        cmdText
        cmdImage
        cmdCustom

    CommandClipping* {.size: sizeof(Flag).} = enum
        clippingOff = false
        clippingOn  = true

    DrawListStroke* {.size: sizeof(Flag).} = enum
        strokeOpen   = false
        strokeClosed = true

const FmtColourStart* = fmtR8G8B8
const FmtColourEnd*   = fmtRgba32

when defined NkUintDrawIndex:
    type DrawIndex* = cuint
else:
    type DrawIndex* = cushort

type
    CommandCustomCallback* = proc(canvas: pointer; x, y: cshort; w, h: cushort; cb_data: Handle) {.cdecl.}

    DrawNullTexture* = object
        tex*: Handle
        uv* : Vec2

    ConvertConfig* = object
        global_alpha*    : cfloat
        line_aa*         : AntiAliasing
        shape_aa*        : AntiAliasing
        circle_seg_count*: cuint
        arc_seg_count*   : cuint
        curve_seg_count* : cuint
        tex_null*        : DrawNullTexture
        layout_elem*     : DrawVertexLayoutElement
        vtx_sz*          : uint
        vtx_align*       : uint

    DrawVertexLayoutElement* = object
        attr*  : DrawVertexLayoutAttribute
        fmt*   : DrawVertexLayoutFormat
        offset*: uint

    CommandBuffer* = object
        base*        : ptr Buffer
        clip*        : Rect
        use_clipping*: cint
        user_data*   : Handle
        begin*       : uint
        `end`*       : uint
        last*        : uint

    DrawCommand* = object
        elem_count*: cuint
        clip_rect* : Rect
        tex*       : Handle
        when defined NkIncludeCommandUserData:
            user_data*: Handle

    DrawList* = object
        clip_rect*  : Rect
        circle_vtx* : array[12, Vec2]
        cfg*        : ConvertConfig
        buf*        : Buffer
        vertices*   : Buffer
        elems*      : Buffer
        elem_count* : cuint
        vtx_count*  : cuint
        cmd_count*  : cuint
        cmd_offset* : uint
        path_count* : cuint
        path_offset*: cuint
        line_aa*    : AntiAliasing
        shape_aa*   : AntiAliasing
        when defined NkIncludeCommandUserData:
            user_data*: Handle

    Command* = object
        kind*: CommandKind
        next*: uint
        when defined NkIncludeCommandUserData:
            user_data*: Handle

    CommandScissor* = object
        header*: Command
        x*, y* : cshort
        w*, h* : cushort

    CommandLine* = object
        header*   : Command
        thickness*: cushort
        begin*    : Vec2I
        `end`*    : Vec2I
        colour*   : Colour

    CommandCurve* = object
        header*   : Command
        thickness*: cushort
        begin*    : Vec2I
        `end`*    : Vec2I
        ctrl*     : array[2, Vec2I]
        colour*   : Colour

    CommandRect* = object
        header*   : Command
        rounding* : cushort
        thickness*: cushort
        x*, y*    : cshort
        w*, h*    : cushort
        colour*   : Colour

    CommandRectFilled* = object
        header*  : Command
        rounding*: cushort
        x*, y*   : cshort
        w*, h*   : cushort
        colour*  : Colour

    CommandRectMultiColour* = object
        header*: Command
        x*, y* : cshort
        left*  : Colour
        top*   : Colour
        bottom*: Colour
        right* : Colour

    CommandTriangle* = object
        header*   : Command
        thickness*: cushort
        a*, b*, c*: Vec2I
        colour*   : Colour

    CommandTriangleFilled* = object
        header*   : Command
        a*, b*, c*: Vec2I
        colour*   : Colour

    CommandCircle* = object
        header*   : Command
        x*, y*    : cshort
        thickness*: cushort
        w*, h*    : cushort
        colour*   : Colour

    CommandCircleFilled* = object
        header*: Command
        x*, y* : cshort
        w*, h* : cushort
        colour*: Colour

    CommandArc* = object
        header*   : Command
        cx*, cy*  : cshort
        r*        : cushort
        thickness*: cushort
        a*        : array[2, cfloat]
        colour*   : Colour

    CommandArcFilled* = object
        header* : Command
        cx*, cy*: cshort
        r*      : cushort
        a*      : array[2, cfloat]
        colour* : Colour

    CommandPolygon* = object
        header*   : Command
        colour*   : Colour
        thickness*: cushort
        pt_count* : cushort
        pts*      : array[1, Vec2I]

    CommandPolygonFilled* = object
        header*  : Command
        colour*  : Colour
        pt_count*: cushort
        pts*     : array[1, Vec2I]

    CommandPolyline* = object
        header*   : Command
        colour*   : Colour
        thickness*: cushort
        pt_count* : cushort
        pts*      : array[1, Vec2I]

    CommandImage* = object
        header*: Command
        x*, y* : cshort
        w*, h* : cushort
        img*   : Image
        colour*: Colour

    CommandCustom* = object
        header* : Command
        x*, y*  : cshort
        w*, h*  : cushort
        cb_data*: Handle
        cb*     : CommandCustomCallback

    CommandText* = object
        header* : Command
        font*   : UserFont
        bg*, fg*: Colour
        x*, y*  : cshort
        w*, h*  : cushort
        height* : cfloat
        len*    : cint
        str*    : array[1, char]

#[ -------------------------------------------------------------------- ]#

using
    ctx    : pointer
    cmd_buf: ptr CommandBuffer
    canvas : ptr DrawList
    colour : Colour
    rect   : Rect
    aa     : AntiAliasing

proc nk_begin*(ctx): ptr Command                  {.importc: "nk__begin".}
proc nk_next*(ctx; cmd: ptr Command): ptr Command {.importc: "nk__next" .}
# TODO
# #define nk_foreach(c, ctx) for((c) = nk__begin(ctx); (c) != 0; (c) = nk__next(ctx,c))
when defined NkIncludeVertexBufferOutput:
    proc nk_convert*(ctx; cmds: ptr Buffer; verts: ptr Buffer; elems: ptr Buffer; cfg: ptr ConvertConfig): Flag {.importc: "nk_convert"    .}
    proc nk_draw_begin*(ctx; cmds: ptr Buffer): ptr DrawCommand                                                 {.importc: "nk__draw_begin".}
    proc nk_draw_end*(ctx; cmds: ptr Buffer): ptr DrawCommand                                                   {.importc: "nk__draw_end"  .}
    proc nk_draw_next*(cmd: ptr DrawCommand; cmds: ptr Buffer; ctx): ptr DrawCommand                            {.importc: "nk__draw_next" .}
    # TODO
    # #define nk_draw_foreach(cmd,ctx, b) for((cmd)=nk__draw_begin(ctx, b); (cmd)!=0; (cmd)=nk__draw_next(cmd, b, ctx))

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

# TODO
# #define nk_draw_list_foreach(cmd, can, b) for((cmd)=nk__draw_list_begin(can, b); (cmd)!=0; (cmd)=nk__draw_list_next(cmd, b, can))
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
