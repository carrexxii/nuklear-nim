import defines
export defines

const
    NkUtfSize*    = 4'i32
    NkUtfInvalid* = 0xFFFD'u32
    NkPi*         = 3.141592654'f32

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

#[ -------------------------------------------------------------------- ]#

type NkTextEdit = object

type
    NkAllocationKind* {.size: sizeof(cint).} = enum
        nkBufferFixed
        nkBufferDynamic

    NkBufferAllocationKind* {.size: sizeof(cint).} = enum
        nkBufferFront
        nkBufferBack

type
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
