import common

type
    FontAtlasFormat* = enum
        fontAtlasAlpha8
        fontAtlasRgba32

    FontCoordKind* = enum
        fontCoordUv
        fontCoordPixel

type
    TextWidthFn*      = proc(handle: Handle; h: cfloat; text: cstring; len: cint): cfloat
    QueryFontGlyphFn* = proc(handle: Handle; font_h: cfloat; glyph: ptr UserFontGlyph; codepoint, next_codepoint: Rune)

    UserFont* = object
        user_data*: Handle
        h*        : cfloat
        w*        : TextWidthFn
        when defined NkIncludeVertexBufferOutput:
            query*: QueryFontGlyphFn
            tex*  : Handle

    UserFontGlyph* = object
        uvs*      : array[2, Vec2]
        offset*   : Vec2
        w*, h*    : cfloat
        x_advance*: cfloat

    FontGlyph* = object
        codepoint*: Rune
        x0*, y0*  : cfloat
        x1*, y1*  : cfloat
        w*, h*    : cfloat
        u0*, v0*  : cfloat
        u1*, v1*  : cfloat

    Font* = object
        next*              : ptr Font
        handle*            : UserFont
        info*              : BakedFont
        scale*             : cfloat
        glyphs*            : ptr FontGlyph
        fallback*          : ptr FontGlyph
        fallback_codepoint*: Rune
        tex*               : Handle
        cfg*               : ptr FontConfig

    BakedFont* = object
        h*           : cfloat
        ascent*      : cfloat
        descent*     : cfloat
        glyph_offset*: Rune
        glyph_count* : Rune
        ranges*      : ptr Rune

    FontConfig* = object
        next*    : ptr FontConfig
        ttf_blob*: pointer
        ttf_sz*  : uint

        ttf_data_owned_by_atlas*: uint8
        merge_mode*             : uint8
        px_snap*                : uint8
        oversample_v*           : uint8
        oversample_h*           : uint8
        _*                      : array[3, byte]

        sz*            : cfloat
        coord_kind*    : FontCoordKind
        spacing*       : Vec2
        range*         : ptr Rune
        font*          : ptr BakedFont
        fallback_glyph*: Rune
        n*             : ptr FontConfig
        p*             : ptr FontConfig

    FontAtlas* = object
        pxs*  : pointer
        w*, h*: cint

        permanent*: Allocator
        temporary*: Allocator

        custom* : RectI
        cursors*: array[7, Cursor] # NkStyleCursor.high

        glyph_count* : cint
        glyphs*      : ptr FontGlyph
        default_font*: ptr Font
        fonts*       : ptr Font
        cfg*         : ptr FontConfig
        font_count*  : cint

#[ -------------------------------------------------------------------- ]#

using
    atlas: ptr FontAtlas
    cfg  : ptr FontConfig

proc nk_font_default_glyph_ranges*(): ptr Rune  {.importc: "nk_font_default_glyph_ranges" .}
proc nk_font_chinese_glyph_ranges*(): ptr Rune  {.importc: "nk_font_chinese_glyph_ranges" .}
proc nk_font_cyrillic_glyph_ranges*(): ptr Rune {.importc: "nk_font_cyrillic_glyph_ranges".}
proc nk_font_korean_glyph_ranges*(): ptr Rune   {.importc: "nk_font_korean_glyph_ranges"  .}

proc nk_font_config*(px_h: cfloat): FontConfig                   {.importc: "nk_font_config"    .}
proc nk_font_find_glyph*(font: ptr Font; c: Rune): ptr FontGlyph {.importc: "nk_font_find_glyph".}

proc nk_font_atlas_init*(atlas; alloc: ptr Allocator)                                        {.importc: "nk_font_atlas_init"                 .}
proc nk_font_atlas_init_custom*(atlas; persistent, transient: ptr Allocator)                 {.importc: "nk_font_atlas_init_custom"          .}
proc nk_font_atlas_begin*(atlas)                                                             {.importc: "nk_font_atlas_begin"                .}
proc nk_font_atlas_add*(atlas; cfg): ptr Font                                                {.importc: "nk_font_atlas_add"                  .}
proc nk_font_atlas_add_from_memory*(atlas; mem: pointer; sz: uint; h: cfloat; cfg): ptr Font {.importc: "nk_font_atlas_add_from_memory"      .}
proc nk_font_atlas_add_compressed*(atlas; mem: pointer; sz: uint; h: cfloat; cfg): ptr Font  {.importc: "nk_font_atlas_add_compressed"       .}
proc nk_font_atlas_add_compressed_base85*(atlas; data: ptr uint8; h: cfloat; cfg): ptr Font  {.importc: "nk_font_atlas_add_compressed_base85".}
proc nk_font_atlas_bake*(atlas; w, h: ptr cint; fmt: FontAtlasFormat): pointer               {.importc: "nk_font_atlas_bake"                 .}
proc nk_font_atlas_end*(atlas; tex: Handle; draw_null_tex: pointer)                          {.importc: "nk_font_atlas_end"                  .}
proc nk_font_atlas_cleanup*(atlas)                                                           {.importc: "nk_font_atlas_cleanup"              .}
proc nk_font_atlas_clear*(atlas)                                                             {.importc: "nk_font_atlas_clear"                .}

when defined NkIncludeDefaultAllocator:
    proc nk_font_atlas_init_default*(atlas) {.importc: "nk_font_atlas_init_default".}
when defined NkIncludeDefaultFont:
    proc nk_font_atlas_add_default*(atlas; h: cfloat; cfg): ptr Font {.importc: "nk_font_atlas_add_default".}
when defined NkIncludeStandardIo:
    proc nk_font_atlas_add_from_file*(atlas; path: cstring; h: cfloat; cfg): ptr Font {.importc: "nk_font_atlas_add_from_file".}
