import common, drawing

type
    NkFontAtlasFormat* = enum
        nkFontAtlasAlpha8
        nkFontAtlasRgba32

    NkFontCoordKind* = enum
        nkCoordUv
        nkCoordPixel

type
    NkTextWidthFn*      = proc(handle: NkHandle; h: float32; text: cstring; len: int32): float32
    NkQueryFontGlyphFn* = proc(handle: NkHandle; font_h: float32; glyph: ptr NkUserFontGlyph; codepoint, next_codepoint: NkRune)

    NkUserFont* = object
        user_data*: NkHandle
        h*: float32
        w*: NkTextWidthFn
        when defined NkIncludeVertexBufferOutput:
            query*: NkQueryFontGlyphFn
            tex*  : NkHandle

    NkUserFontGlyph* = object
        uvs*      : array[2, NkVec2]
        offset*   : NkVec2
        w*, h*    : float32
        x_advance*: float32

    NkFontGlyph* = object
        codepoint*: NkRune
        x0*, y0*  : float32
        x1*, y1*  : float32
        w*, h*    : float32
        u0*, v0*  : float32
        u1*, v1*  : float32

    NkFont* = object
        next*              : ptr NkFont
        handle*            : NkUserFont
        info*              : NkBakedFont
        scale*             : float32
        glyphs*            : ptr NkFontGlyph
        fallback*          : ptr NkFontGlyph
        fallback_codepoint*: NkRune
        tex*               : NkHandle
        config*            : ptr NkFontConfig

    NkBakedFont* = object
        h*           : float32
        ascent*      : float32
        descent*     : float32
        glyph_offset*: NkRune
        glyph_count* : NkRune
        ranges*      : ptr NkRune

    NkFontConfig* = object
        next*    : ptr NkFontConfig
        ttf_blob*: pointer
        ttf_sz*  : uint

        ttf_data_owned_by_atlas*: uint8
        merge_mode*             : uint8
        px_snap*                : uint8
        oversample_v*           : uint8
        oversample_h*           : uint8
        _*                      : array[3, uint8]

        sz*            : float32
        coord_kind*    : NkFontCoordKind
        spacing*       : NkVec2
        range*         : ptr NkRune
        font*          : ptr NkBakedFont
        fallback_glyph*: NkRune
        n*             : ptr NkFontConfig
        p*             : ptr NkFontConfig

    NkFontAtlas* = object
        pxs*  : pointer
        w*, h*: int32

        permanent*: NkAllocator
        temporary*: NkAllocator

        custom* : NkRectI
        cursors*: array[7, NkCursor] # NkStyleCursor.high

        glyph_count* : int32
        glyphs*      : ptr NkFontGlyph
        default_font*: ptr NkFont
        fonts*       : ptr NkFont
        config*      : ptr NkFontConfig
        font_count*  : int32

#[ -------------------------------------------------------------------- ]#

using
    atlas: ptr NkFontAtlas
    cfg  : ptr NkFontConfig

proc nk_font_default_glyph_ranges*(): ptr NkRune  {.importc: "nk_font_default_glyph_ranges" .}
proc nk_font_chinese_glyph_ranges*(): ptr NkRune  {.importc: "nk_font_chinese_glyph_ranges" .}
proc nk_font_cyrillic_glyph_ranges*(): ptr NkRune {.importc: "nk_font_cyrillic_glyph_ranges".}
proc nk_font_korean_glyph_ranges*(): ptr NkRune   {.importc: "nk_font_korean_glyph_ranges"  .}

proc nk_font_config*(px_h: float32): NkFontConfig                      {.importc: "nk_font_config"    .}
proc nk_font_find_glyph*(font: ptr NkFont; c: NkRune): ptr NkFontGlyph {.importc: "nk_font_find_glyph".}

proc nk_font_atlas_init*(atlas; alloc: ptr NkAllocator)                                         {.importc: "nk_font_atlas_init"                 .}
proc nk_font_atlas_init_custom*(atlas; persistent, transient: ptr NkAllocator)                  {.importc: "nk_font_atlas_init_custom"          .}
proc nk_font_atlas_begin*(atlas)                                                                {.importc: "nk_font_atlas_begin"                .}
proc nk_font_atlas_add*(atlas; cfg): ptr NkFont                                                 {.importc: "nk_font_atlas_add"                  .}
proc nk_font_atlas_add_from_memory*(atlas; mem: pointer; sz: uint; h: float32; cfg): ptr NkFont {.importc: "nk_font_atlas_add_from_memory"      .}
proc nk_font_atlas_add_compressed*(atlas; mem: pointer; sz: uint; h: float32; cfg): ptr NkFont  {.importc: "nk_font_atlas_add_compressed"       .}
proc nk_font_atlas_add_compressed_base85*(atlas; data: ptr uint8; h: float32; cfg): ptr NkFont  {.importc: "nk_font_atlas_add_compressed_base85".}
proc nk_font_atlas_bake*(atlas; w, h: ptr int32; fmt: NkFontAtlasFormat): pointer               {.importc: "nk_font_atlas_bake"                 .}
proc nk_font_atlas_end*(atlas; tex: NkHandle; draw_tex: ptr NkDrawNullTexture)                  {.importc: "nk_font_atlas_end"                  .}
proc nk_font_atlas_cleanup*(atlas)                                                              {.importc: "nk_font_atlas_cleanup"              .}
proc nk_font_atlas_clear*(atlas)                                                                {.importc: "nk_font_atlas_clear"                .}

when defined NkIncludeDefaultAllocator:
    {.passC: "-DNK_INCLUDE_DEFAULT_ALLOCATOR".}
    proc nk_font_atlas_init_default*(atlas) {.importc: "nk_font_atlas_init_default".}
when defined NkIncludeDefaultFont:
    {.passC: "-DNK_INCLUDE_DEFAULT_FONT".}
    proc nk_font_atlas_add_default*(atlas; h: float32; cfg): ptr NkFont {.importc: "nk_font_atlas_add_default".}
when defined NkIncludeStandardIo:
    {.passC: "-DNK_INCLUDE_STANDARD_IO".}
    proc nk_font_atlas_add_from_file*(atlas; path: cstring; h: float32; cfg): ptr NkFont {.importc: "nk_font_atlas_add_from_file".}
