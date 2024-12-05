import common

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
proc nk_font_atlas_clear*(atlas)                                                             {.importc: "nk_font_atlas_clear"                .}

when defined NkIncludeDefaultAllocator:
    proc nk_font_atlas_init_default*(atlas) {.importc: "nk_font_atlas_init_default".}
when defined NkIncludeDefaultFont:
    proc nk_font_atlas_add_default*(atlas; h: cfloat; cfg): ptr Font {.importc: "nk_font_atlas_add_default".}
when defined NkIncludeStandardIo:
    proc nk_font_atlas_add_from_file*(atlas; path: cstring; h: cfloat; cfg): ptr Font {.importc: "nk_font_atlas_add_from_file".}

#[ -------------------------------------------------------------------- ]#

using atlas: var FontAtlas

{.push inline.}

proc init*(atlas; allocator = NimAllocator) =
    nk_font_atlas_init atlas.addr, allocator.addr

proc begin*(atlas) =
    nk_font_atlas_begin atlas.addr

proc `end`*(atlas; tex: Handle | pointer; draw_null_tex: pointer = nil) =
    nk_font_atlas_end atlas.addr, tex, draw_null_tex

proc add*(atlas; cfg: FontConfig): ptr Font {.discardable.} =
    nk_font_atlas_add atlas.addr, cfg.addr

proc bake*(atlas; fmt = fafAlpha8): tuple[pxs: pointer; w, h: int32] =
    var w, h: cint
    result.pxs = nk_font_atlas_bake(atlas.addr, w.addr, h.addr, fmt)
    result.w   = int32 w
    result.h   = int32 h

proc clear*(atlas) =
    nk_font_atlas_clear atlas.addr

{.pop.}
