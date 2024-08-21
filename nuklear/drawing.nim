import common

{.push size: sizeof(cint).}
type
    NkAntiAliasing* = enum
        nkAntiAliasingOff
        nkAntiAliasingOn

    NkConvertResult* = enum
        nkConvertSuccess           = 0
        nkConvertInvalidParam      = 1
        nkConvertCommandBufferFull = 1 shl 1
        nkConvertVertexBufferFull  = 1 shl 2
        nkConvertElementBufferFull = 1 shl 3

    NkDrawVertexLayoutAttribute* = enum
        nkVertexPosition
        nkVertexColour
        nkVertexTexcoord

    NkDrawVertexLayoutFormat* = enum
        nkFormatSchar
        nkFormatSshort
        nkFormatSint
        nkFormatUchar
        nkFormatUshort
        nkFormatUint
        nkFormatFloat
        nkFormatDouble

        nkFormatR8G8B8
        nkFormatR16G15B16
        nkFormatR32G32B32
        nkFormatR8G8B8A8
        nkFormatB8G8R8A8
        nkFormatR16G15B16A16
        nkFormatR32G32B32A32
        nkFormatR32G32B32A32Float
        nkFormatR32G32B32A32Double
        nkFormatRgb32
        nkFormatRgba32
{.pop.} # size: sizeof(cint)

const nkFormatColourStart* = nkFormatR8G8B8
const nkFormatColourEnd*   = nkFormatRgba32

type
    NkDrawNullTexture* = object
        tex*: NkHandle
        uv* : NkVec2

    NkConvertConfig* = object
        global_alpha*    : float32
        line_aa*         : NkAntiAliasing
        shape_aa*        : NkAntiAliasing
        circle_seg_count*: uint32
        arc_seg_count*   : uint32
        curve_seg_count* : uint32
        tex_null*        : NkDrawNullTexture
        layout_elem*     : NkDrawVertexLayoutElement
        vert_sz*         : uint
        vert_align*      : uint

    NkDrawVertexLayoutElement* = object
        attr*  : NkDrawVertexLayoutAttribute
        fmt*   : NkDrawVertexLayoutFormat
        offset*: uint

    NkCommandBuffer* = object
        base*: ptr NkBuffer
        clip*: NkRect
        use_clipping*: int32
        user_data*   : NkHandle
        begin*: uint
        `end`*: uint
        last* : uint

#[ -------------------------------------------------------------------- ]#

using ctx: pointer

# proc nk_begin*(ctx): ptr NkCommand                    {.importc: "nk__begin".}
# proc nk_next*(ctx; cmd: ptr NkCommand): ptr NkCommand {.importc: "nk__next" .}

# #define nk_foreach(c, ctx) for((c) = nk__begin(ctx); (c) != 0; (c) = nk__next(ctx,c))

when defined NkIncludeVertexBufferOutput:
    {.passC: "-DNK_INCLUDE_VERTEX_BUFFER_OUTPUT".}
    proc nk_convert*(ctx; cmds: ptr NkBuffer; verts: ptr NkBuffer; elems: ptr NkBuffer;
                     cfg: ptr NkConvertConfig): NkFlag                                     {.importc: "nk_convert"    .}
    proc nk_draw_begin*(ctx; cmds: ptr NkBuffer): ptr NkDrawCommand                        {.importc: "nk__draw_begin".}
    proc nk_draw_end*(ctx; cmds: ptr NkBuffer): ptr NkDrawCommand                          {.importc: "nk__draw_end"  .}
    proc nk_draw_next*(cmd: ptr NkDrawCommand; cmds: ptr NkBuffer; ctx): ptr NkDrawCommand {.importc: "nk__draw_next" .}
    # #define nk_draw_foreach(cmd,ctx, b) for((cmd)=nk__draw_begin(ctx, b); (cmd)!=0; (cmd)=nk__draw_next(cmd, b, ctx))

# enum nk_command_type {
#     NK_COMMAND_NOP,
#     NK_COMMAND_SCISSOR,
#     NK_COMMAND_LINE,
#     NK_COMMAND_CURVE,
#     NK_COMMAND_RECT,
#     NK_COMMAND_RECT_FILLED,
#     NK_COMMAND_RECT_MULTI_COLOR,
#     NK_COMMAND_CIRCLE,
#     NK_COMMAND_CIRCLE_FILLED,
#     NK_COMMAND_ARC,
#     NK_COMMAND_ARC_FILLED,
#     NK_COMMAND_TRIANGLE,
#     NK_COMMAND_TRIANGLE_FILLED,
#     NK_COMMAND_POLYGON,
#     NK_COMMAND_POLYGON_FILLED,
#     NK_COMMAND_POLYLINE,
#     NK_COMMAND_TEXT,
#     NK_COMMAND_IMAGE,
#     NK_COMMAND_CUSTOM
# };

# /* command base and header of every command inside the buffer */
# struct nk_command {
#     enum nk_command_type type;
#     nk_size next;
# #ifdef NK_INCLUDE_COMMAND_USERDATA
#     nk_handle userdata;
# #endif
# };

# struct nk_command_scissor {
#     struct nk_command header;
#     short x, y;
#     unsigned short w, h;
# };

# struct nk_command_line {
#     struct nk_command header;
#     unsigned short line_thickness;
#     struct nk_vec2i begin;
#     struct nk_vec2i end;
#     struct nk_color color;
# };

# struct nk_command_curve {
#     struct nk_command header;
#     unsigned short line_thickness;
#     struct nk_vec2i begin;
#     struct nk_vec2i end;
#     struct nk_vec2i ctrl[2];
#     struct nk_color color;
# };

# struct nk_command_rect {
#     struct nk_command header;
#     unsigned short rounding;
#     unsigned short line_thickness;
#     short x, y;
#     unsigned short w, h;
#     struct nk_color color;
# };

# struct nk_command_rect_filled {
#     struct nk_command header;
#     unsigned short rounding;
#     short x, y;
#     unsigned short w, h;
#     struct nk_color color;
# };

# struct nk_command_rect_multi_color {
#     struct nk_command header;
#     short x, y;
#     unsigned short w, h;
#     struct nk_color left;
#     struct nk_color top;
#     struct nk_color bottom;
#     struct nk_color right;
# };

# struct nk_command_triangle {
#     struct nk_command header;
#     unsigned short line_thickness;
#     struct nk_vec2i a;
#     struct nk_vec2i b;
#     struct nk_vec2i c;
#     struct nk_color color;
# };

# struct nk_command_triangle_filled {
#     struct nk_command header;
#     struct nk_vec2i a;
#     struct nk_vec2i b;
#     struct nk_vec2i c;
#     struct nk_color color;
# };

# struct nk_command_circle {
#     struct nk_command header;
#     short x, y;
#     unsigned short line_thickness;
#     unsigned short w, h;
#     struct nk_color color;
# };

# struct nk_command_circle_filled {
#     struct nk_command header;
#     short x, y;
#     unsigned short w, h;
#     struct nk_color color;
# };

# struct nk_command_arc {
#     struct nk_command header;
#     short cx, cy;
#     unsigned short r;
#     unsigned short line_thickness;
#     float a[2];
#     struct nk_color color;
# };

# struct nk_command_arc_filled {
#     struct nk_command header;
#     short cx, cy;
#     unsigned short r;
#     float a[2];
#     struct nk_color color;
# };

# struct nk_command_polygon {
#     struct nk_command header;
#     struct nk_color color;
#     unsigned short line_thickness;
#     unsigned short point_count;
#     struct nk_vec2i points[1];
# };

# struct nk_command_polygon_filled {
#     struct nk_command header;
#     struct nk_color color;
#     unsigned short point_count;
#     struct nk_vec2i points[1];
# };

# struct nk_command_polyline {
#     struct nk_command header;
#     struct nk_color color;
#     unsigned short line_thickness;
#     unsigned short point_count;
#     struct nk_vec2i points[1];
# };

# struct nk_command_image {
#     struct nk_command header;
#     short x, y;
#     unsigned short w, h;
#     struct nk_image img;
#     struct nk_color col;
# };

# typedef void (*nk_command_custom_callback)(void *canvas, short x,short y,
#     unsigned short w, unsigned short h, nk_handle callback_data);
# struct nk_command_custom {
#     struct nk_command header;
#     short x, y;
#     unsigned short w, h;
#     nk_handle callback_data;
#     nk_command_custom_callback callback;
# };

# struct nk_command_text {
#     struct nk_command header;
#     const struct nk_user_font *font;
#     struct nk_color background;
#     struct nk_color foreground;
#     short x, y;
#     unsigned short w, h;
#     float height;
#     int length;
#     char string[1];
# };

# enum nk_command_clipping {
#     NK_CLIPPING_OFF = nk_false,
#     NK_CLIPPING_ON = nk_true
# };

# /* shape outlines */
# NK_API void nk_stroke_line(struct nk_command_buffer *b, float x0, float y0, float x1, float y1, float line_thickness, struct nk_color);
# NK_API void nk_stroke_curve(struct nk_command_buffer*, float, float, float, float, float, float, float, float, float line_thickness, struct nk_color);
# NK_API void nk_stroke_rect(struct nk_command_buffer*, struct nk_rect, float rounding, float line_thickness, struct nk_color);
# NK_API void nk_stroke_circle(struct nk_command_buffer*, struct nk_rect, float line_thickness, struct nk_color);
# NK_API void nk_stroke_arc(struct nk_command_buffer*, float cx, float cy, float radius, float a_min, float a_max, float line_thickness, struct nk_color);
# NK_API void nk_stroke_triangle(struct nk_command_buffer*, float, float, float, float, float, float, float line_thichness, struct nk_color);
# NK_API void nk_stroke_polyline(struct nk_command_buffer*, float *points, int point_count, float line_thickness, struct nk_color col);
# NK_API void nk_stroke_polygon(struct nk_command_buffer*, float*, int point_count, float line_thickness, struct nk_color);

# /* filled shades */
# NK_API void nk_fill_rect(struct nk_command_buffer*, struct nk_rect, float rounding, struct nk_color);
# NK_API void nk_fill_rect_multi_color(struct nk_command_buffer*, struct nk_rect, struct nk_color left, struct nk_color top, struct nk_color right, struct nk_color bottom);
# NK_API void nk_fill_circle(struct nk_command_buffer*, struct nk_rect, struct nk_color);
# NK_API void nk_fill_arc(struct nk_command_buffer*, float cx, float cy, float radius, float a_min, float a_max, struct nk_color);
# NK_API void nk_fill_triangle(struct nk_command_buffer*, float x0, float y0, float x1, float y1, float x2, float y2, struct nk_color);
# NK_API void nk_fill_polygon(struct nk_command_buffer*, float*, int point_count, struct nk_color);

# /* misc */
# NK_API void nk_draw_image(struct nk_command_buffer*, struct nk_rect, const struct nk_image*, struct nk_color);
# NK_API void nk_draw_nine_slice(struct nk_command_buffer*, struct nk_rect, const struct nk_nine_slice*, struct nk_color);
# NK_API void nk_draw_text(struct nk_command_buffer*, struct nk_rect, const char *text, int len, const struct nk_user_font*, struct nk_color, struct nk_color);
# NK_API void nk_push_scissor(struct nk_command_buffer*, struct nk_rect);
# NK_API void nk_push_custom(struct nk_command_buffer*, struct nk_rect, nk_command_custom_callback, nk_handle usr);

# #ifdef NK_UINT_DRAW_INDEX
# typedef nk_uint nk_draw_index;
# #else
# typedef nk_ushort nk_draw_index;
# #endif
# enum nk_draw_list_stroke {
#     NK_STROKE_OPEN = nk_false,
#     /* build up path has no connection back to the beginning */
#     NK_STROKE_CLOSED = nk_true
#     /* build up path has a connection back to the beginning */
# };

# struct nk_draw_command {
#     unsigned int elem_count;
#     /* number of elements in the current draw batch */
#     struct nk_rect clip_rect;
#     /* current screen clipping rectangle */
#     nk_handle texture;
#     /* current texture to set */
# #ifdef NK_INCLUDE_COMMAND_USERDATA
#     nk_handle userdata;
# #endif
# };

# struct nk_draw_list {
#     struct nk_rect clip_rect;
#     struct nk_vec2 circle_vtx[12];
#     struct nk_convert_config config;

#     struct nk_buffer *buffer;
#     struct nk_buffer *vertices;
#     struct nk_buffer *elements;

#     unsigned int element_count;
#     unsigned int vertex_count;
#     unsigned int cmd_count;
#     nk_size cmd_offset;

#     unsigned int path_count;
#     unsigned int path_offset;

#     enum nk_anti_aliasing line_AA;
#     enum nk_anti_aliasing shape_AA;

# #ifdef NK_INCLUDE_COMMAND_USERDATA
#     nk_handle userdata;
# #endif
# };

# /* draw list */
# NK_API void nk_draw_list_init(struct nk_draw_list*);
# NK_API void nk_draw_list_setup(struct nk_draw_list*, const struct nk_convert_config*, struct nk_buffer *cmds, struct nk_buffer *vertices, struct nk_buffer *elements, enum nk_anti_aliasing line_aa,enum nk_anti_aliasing shape_aa);

# /* drawing */
# #define nk_draw_list_foreach(cmd, can, b) for((cmd)=nk__draw_list_begin(can, b); (cmd)!=0; (cmd)=nk__draw_list_next(cmd, b, can))
# NK_API const struct nk_draw_command* nk__draw_list_begin(const struct nk_draw_list*, const struct nk_buffer*);
# NK_API const struct nk_draw_command* nk__draw_list_next(const struct nk_draw_command*, const struct nk_buffer*, const struct nk_draw_list*);
# NK_API const struct nk_draw_command* nk__draw_list_end(const struct nk_draw_list*, const struct nk_buffer*);

# /* path */
# NK_API void nk_draw_list_path_clear(struct nk_draw_list*);
# NK_API void nk_draw_list_path_line_to(struct nk_draw_list*, struct nk_vec2 pos);
# NK_API void nk_draw_list_path_arc_to_fast(struct nk_draw_list*, struct nk_vec2 center, float radius, int a_min, int a_max);
# NK_API void nk_draw_list_path_arc_to(struct nk_draw_list*, struct nk_vec2 center, float radius, float a_min, float a_max, unsigned int segments);
# NK_API void nk_draw_list_path_rect_to(struct nk_draw_list*, struct nk_vec2 a, struct nk_vec2 b, float rounding);
# NK_API void nk_draw_list_path_curve_to(struct nk_draw_list*, struct nk_vec2 p2, struct nk_vec2 p3, struct nk_vec2 p4, unsigned int num_segments);
# NK_API void nk_draw_list_path_fill(struct nk_draw_list*, struct nk_color);
# NK_API void nk_draw_list_path_stroke(struct nk_draw_list*, struct nk_color, enum nk_draw_list_stroke closed, float thickness);

# /* stroke */
# NK_API void nk_draw_list_stroke_line(struct nk_draw_list*, struct nk_vec2 a, struct nk_vec2 b, struct nk_color, float thickness);
# NK_API void nk_draw_list_stroke_rect(struct nk_draw_list*, struct nk_rect rect, struct nk_color, float rounding, float thickness);
# NK_API void nk_draw_list_stroke_triangle(struct nk_draw_list*, struct nk_vec2 a, struct nk_vec2 b, struct nk_vec2 c, struct nk_color, float thickness);
# NK_API void nk_draw_list_stroke_circle(struct nk_draw_list*, struct nk_vec2 center, float radius, struct nk_color, unsigned int segs, float thickness);
# NK_API void nk_draw_list_stroke_curve(struct nk_draw_list*, struct nk_vec2 p0, struct nk_vec2 cp0, struct nk_vec2 cp1, struct nk_vec2 p1, struct nk_color, unsigned int segments, float thickness);
# NK_API void nk_draw_list_stroke_poly_line(struct nk_draw_list*, const struct nk_vec2 *pnts, const unsigned int cnt, struct nk_color, enum nk_draw_list_stroke, float thickness, enum nk_anti_aliasing);

# /* fill */
# NK_API void nk_draw_list_fill_rect(struct nk_draw_list*, struct nk_rect rect, struct nk_color, float rounding);
# NK_API void nk_draw_list_fill_rect_multi_color(struct nk_draw_list*, struct nk_rect rect, struct nk_color left, struct nk_color top, struct nk_color right, struct nk_color bottom);
# NK_API void nk_draw_list_fill_triangle(struct nk_draw_list*, struct nk_vec2 a, struct nk_vec2 b, struct nk_vec2 c, struct nk_color);
# NK_API void nk_draw_list_fill_circle(struct nk_draw_list*, struct nk_vec2 center, float radius, struct nk_color col, unsigned int segs);
# NK_API void nk_draw_list_fill_poly_convex(struct nk_draw_list*, const struct nk_vec2 *points, const unsigned int count, struct nk_color, enum nk_anti_aliasing);

# /* misc */
# NK_API void nk_draw_list_add_image(struct nk_draw_list*, struct nk_image texture, struct nk_rect rect, struct nk_color);
# NK_API void nk_draw_list_add_text(struct nk_draw_list*, const struct nk_user_font*, struct nk_rect, const char *text, int len, float font_height, struct nk_color);
# #ifdef NK_INCLUDE_COMMAND_USERDATA
# NK_API void nk_draw_list_push_userdata(struct nk_draw_list*, nk_handle userdata);
# #endif

# #endif
