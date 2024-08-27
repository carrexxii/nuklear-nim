import defines
export defines

const
    NkUtfSize*    = 4'i32
    NkUtfInvalid* = 0xFFFD'u32
    NkPi*         = 3.141592654'f32

type NkTextEdit = object

type
    NkHeadingKind* = enum
        nkUp
        nkRight
        nkDown
        nkLeft

    NkButtonBehaviour* = enum
        nkButtonDefault
        nkButtonRepeater

    NkModifyKind* = enum
        nkFixed
        nkModifiable

    NkOrientation* = enum
        nkVertical
        nkHorizontal

    NkCollapseState* = enum
        nkMinimized
        nkMaximized

    NkShowState* = enum
        nkHidden
        nkShown

    NkChartEvent* = enum
        nkChartHovering = 0x01
        nkChartClicked  = 0x02

    NkColourFormat* = enum
        nkRgb
        nkRgba

    NkPopupKind* = enum
        nkPopupStatic
        nkPopupDynamic

    NkLayoutFormat* = enum
        nkDynamic
        nkStatic

    NkSymbolKind* = enum
        nkSymNone
        nkSymX
        nkSymUnderscore
        nkSymCircleSolid
        nkSymCircleOutline
        nkSymRectSolid
        nkSymRectOutline
        nkSymTriangleUp
        nkSymTriangleDown
        nkSymTriangleLeft
        nkSymTriangleRight
        nkSymPlus
        nkSymMinus
        nkSymTriangleUpOutline
        nkSymTriangleDownOutline
        nkSymTriangleLeftOutline
        nkSymTriangleRightOutline

    NkAllocationKind* {.size: sizeof(cint).} = enum
        nkBufFixed
        nkBufDynamic

    NkBufferAllocationKind* {.size: sizeof(cint).} = enum
        nkBufFront
        nkBufBack

type
    NkHash* = uint32
    NkFlag* = uint32
    NkRune* = uint32

    NkColour* = object
        r*, g*, b*, a*: uint8

    NkColourF* = object
        r*, g*, b*, a*: float32

    NkVec2I* = object
        x*, y*: int16

    NkVec2* = object
        x*, y*: float32

    NkRectI* = object
        x*, y*, w*, h*: int16

    NkRect* = object
        x*, y*, w*, h*: float32

    NkGlyph* = array[NkUtfSize, char]

    NkHandle* {.union.} = object
        p* : pointer
        id*: int32

    NkImage* = object
        handle*: NkHandle
        w*, h* : uint16
        region*: array[4, uint16]

    NkNineSlice* = object
        img*  : NkImage
        l*, t*: uint16
        r*, b*: uint16

    NkCursor* = object
        img*   : NkImage
        sz*    : NkVec2
        offset*: NkVec2

    NkScroll* = object
        x*, y*: uint32

    NkString* = object
        buf*: NkBuffer
        len*: int32

    NkPluginAlloc*  = proc(handle: NkHandle; old: pointer; sz: uint): pointer
    NkPluginFree*   = proc(handle: NkHandle; old: pointer)
    NkPluginFilter* = proc(te: ptr NkTextEdit; unicode: NkRune): bool
    NkPluginPaste*  = proc(handle: NkHandle; te: ptr NkTextEdit)
    NkPluginCopy*   = proc(handle: NkHandle; str: cstring; len: int32)

    NkMemoryStatus* = object
        mem*    : pointer
        kind*   : uint32
        sz*     : uint
        alloced*: uint
        needed* : uint
        calls*  : uint

    NkBufferMarker* = object
        active*: bool
        offset*: uint

    NkMemory* = object
        mem*: pointer
        sz* : uint

    NkAllocator* = object
        user_data*: NkHandle
        alloc*    : NkPluginAlloc
        free*     : NkPluginFree

    NkBuffer* = object
        markers*    : array[1 + int NkBufferAllocationKind.high, NkBufferMarker]
        pool*       : NkAllocator
        kind*       : NkAllocationKind
        mem*        : NkMemory
        grow_factor*: float32
        alloced*    : uint
        needed*     : uint
        calls*      : uint
        sz*         : uint

converter `pointer -> NkHandle`*(p: pointer): NkHandle =
    result.p = p

proc nim_alloc*(handle: NkHandle; old: pointer; sz: uint): pointer =
    old.realloc sz

proc nim_dealloc*(handle: NkHandle; old: pointer) =
    dealloc old

# #define NK_PI 3.141592654f
# #define NK_UTF_INVALID 0xFFFD
# #define NK_MAX_FLOAT_PRECISION 2

# #define NK_UNUSED(x) ((void)(x))
# #define NK_SATURATE(x) (NK_MAX(0, NK_MIN(1.0f, x)))
# #define NK_LEN(a) (sizeof(a)/sizeof(a)[0])
# #define NK_ABS(a) (((a) < 0) ? -(a) : (a))
# #define NK_BETWEEN(x, a, b) ((a) <= (x) && (x) < (b))
# #define NK_INBOX(px, py, x, y, w, h)\
#     (NK_BETWEEN(px,x,x+w) && NK_BETWEEN(py,y,y+h))
# #define NK_INTERSECT(x0, y0, w0, h0, x1, y1, w1, h1) \
#     ((x1 < (x0 + w0)) && (x0 < (x1 + w1)) && \
#     (y1 < (y0 + h0)) && (y0 < (y1 + h1)))
# #define NK_CONTAINS(x, y, w, h, bx, by, bw, bh)\
#     (NK_INBOX(x,y, bx, by, bw, bh) && NK_INBOX(x+w,y+h, bx, by, bw, bh))

# #define nk_vec2_sub(a, b) nk_vec2((a).x - (b).x, (a).y - (b).y)
# #define nk_vec2_add(a, b) nk_vec2((a).x + (b).x, (a).y + (b).y)
# #define nk_vec2_len_sqr(a) ((a).x*(a).x+(a).y*(a).y)
# #define nk_vec2_muls(a, t) nk_vec2((a).x * (t), (a).y * (t))

# #define nk_ptr_add(t, p, i) ((t*)((void*)((nk_byte*)(p) + (i))))
# #define nk_ptr_add_const(t, p, i) ((const t*)((const void*)((const nk_byte*)(p) + (i))))
# #define nk_zero_struct(s) nk_zero(&s, sizeof(s))

# #ifdef NK_INCLUDE_DEFAULT_ALLOCATOR
# NK_API void nk_buffer_init_default(struct nk_buffer*);
# #endif
# NK_API void nk_buffer_init(struct nk_buffer*, const struct nk_allocator*, nk_size size);
# NK_API void nk_buffer_init_fixed(struct nk_buffer*, void *memory, nk_size size);
# NK_API void nk_buffer_info(struct nk_memory_status*, struct nk_buffer*);
# NK_API void nk_buffer_push(struct nk_buffer*, enum nk_buffer_allocation_type type, const void *memory, nk_size size, nk_size align);
# NK_API void nk_buffer_mark(struct nk_buffer*, enum nk_buffer_allocation_type type);
# NK_API void nk_buffer_reset(struct nk_buffer*, enum nk_buffer_allocation_type type);
# NK_API void nk_buffer_clear(struct nk_buffer*);
# NK_API void nk_buffer_free(struct nk_buffer*);
# NK_API void *nk_buffer_memory(struct nk_buffer*);
# NK_API const void *nk_buffer_memory_const(const struct nk_buffer*);
# NK_API nk_size nk_buffer_total(struct nk_buffer*);

# NK_API struct nk_color nk_rgb(int r, int g, int b);
# NK_API struct nk_color nk_rgb_iv(const int *rgb);
# NK_API struct nk_color nk_rgb_bv(const nk_byte* rgb);
# NK_API struct nk_color nk_rgb_f(float r, float g, float b);
# NK_API struct nk_color nk_rgb_fv(const float *rgb);
# NK_API struct nk_color nk_rgb_cf(struct nk_colorf c);
# NK_API struct nk_color nk_rgb_hex(const char *rgb);
# NK_API struct nk_color nk_rgb_factor(struct nk_color col, const float factor);

# NK_API struct nk_color nk_rgba(int r, int g, int b, int a);
# NK_API struct nk_color nk_rgba_u32(nk_uint);
# NK_API struct nk_color nk_rgba_iv(const int *rgba);
# NK_API struct nk_color nk_rgba_bv(const nk_byte *rgba);
# NK_API struct nk_color nk_rgba_f(float r, float g, float b, float a);
# NK_API struct nk_color nk_rgba_fv(const float *rgba);
# NK_API struct nk_color nk_rgba_cf(struct nk_colorf c);
# NK_API struct nk_color nk_rgba_hex(const char *rgb);

# NK_API struct nk_colorf nk_hsva_colorf(float h, float s, float v, float a);
# NK_API struct nk_colorf nk_hsva_colorfv(float *c);
# NK_API void nk_colorf_hsva_f(float *out_h, float *out_s, float *out_v, float *out_a, struct nk_colorf in);
# NK_API void nk_colorf_hsva_fv(float *hsva, struct nk_colorf in);

# NK_API struct nk_color nk_hsv(int h, int s, int v);
# NK_API struct nk_color nk_hsv_iv(const int *hsv);
# NK_API struct nk_color nk_hsv_bv(const nk_byte *hsv);
# NK_API struct nk_color nk_hsv_f(float h, float s, float v);
# NK_API struct nk_color nk_hsv_fv(const float *hsv);

# NK_API struct nk_color nk_hsva(int h, int s, int v, int a);
# NK_API struct nk_color nk_hsva_iv(const int *hsva);
# NK_API struct nk_color nk_hsva_bv(const nk_byte *hsva);
# NK_API struct nk_color nk_hsva_f(float h, float s, float v, float a);
# NK_API struct nk_color nk_hsva_fv(const float *hsva);

# /* color (conversion nuklear --> user) */
# NK_API void nk_color_f(float *r, float *g, float *b, float *a, struct nk_color);
# NK_API void nk_color_fv(float *rgba_out, struct nk_color);
# NK_API struct nk_colorf nk_color_cf(struct nk_color);
# NK_API void nk_color_d(double *r, double *g, double *b, double *a, struct nk_color);
# NK_API void nk_color_dv(double *rgba_out, struct nk_color);

# NK_API nk_uint nk_color_u32(struct nk_color);
# NK_API void nk_color_hex_rgba(char *output, struct nk_color);
# NK_API void nk_color_hex_rgb(char *output, struct nk_color);

# NK_API void nk_color_hsv_i(int *out_h, int *out_s, int *out_v, struct nk_color);
# NK_API void nk_color_hsv_b(nk_byte *out_h, nk_byte *out_s, nk_byte *out_v, struct nk_color);
# NK_API void nk_color_hsv_iv(int *hsv_out, struct nk_color);
# NK_API void nk_color_hsv_bv(nk_byte *hsv_out, struct nk_color);
# NK_API void nk_color_hsv_f(float *out_h, float *out_s, float *out_v, struct nk_color);
# NK_API void nk_color_hsv_fv(float *hsv_out, struct nk_color);

# NK_API void nk_color_hsva_i(int *h, int *s, int *v, int *a, struct nk_color);
# NK_API void nk_color_hsva_b(nk_byte *h, nk_byte *s, nk_byte *v, nk_byte *a, struct nk_color);
# NK_API void nk_color_hsva_iv(int *hsva_out, struct nk_color);
# NK_API void nk_color_hsva_bv(nk_byte *hsva_out, struct nk_color);
# NK_API void nk_color_hsva_f(float *out_h, float *out_s, float *out_v, float *out_a, struct nk_color);
# NK_API void nk_color_hsva_fv(float *hsva_out, struct nk_color);
