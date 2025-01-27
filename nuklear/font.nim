import common

using
    atlas: ptr FontAtlas
    cfg  : ptr FontConfig

{.push importc, cdecl.}
proc nk_font_default_glyph_ranges*(): ptr Rune
proc nk_font_chinese_glyph_ranges*(): ptr Rune
proc nk_font_cyrillic_glyph_ranges*(): ptr Rune
proc nk_font_korean_glyph_ranges*(): ptr Rune

proc nk_font_config*(px_h: cfloat): FontConfig
proc nk_font_find_glyph*(font: ptr Font; c: Rune): ptr FontGlyph

proc nk_font_atlas_init*(atlas; alloc: ptr Allocator)
proc nk_font_atlas_init_custom*(atlas; persistent, transient: ptr Allocator)
proc nk_font_atlas_begin*(atlas)
proc nk_font_atlas_add*(atlas; cfg): ptr Font
proc nk_font_atlas_add_from_memory*(atlas; mem: pointer; sz: uint; h: cfloat; cfg): ptr Font
proc nk_font_atlas_add_compressed*(atlas; mem: pointer; sz: uint; h: cfloat; cfg): ptr Font
proc nk_font_atlas_add_compressed_base85*(atlas; data: ptr uint8; h: cfloat; cfg): ptr Font
proc nk_font_atlas_bake*(atlas; w, h: ptr cint; fmt: FontAtlasFormat): pointer
proc nk_font_atlas_end*(atlas; tex: Handle; draw_null_tex: pointer)
proc nk_font_atlas_clear*(atlas)

when defined NkIncludeDefaultAllocator:
    proc nk_font_atlas_init_default*(atlas)
when defined NkIncludeDefaultFont:
    proc nk_font_atlas_add_default*(atlas; h: cfloat; cfg): ptr Font
when defined NkIncludeStandardIo:
    proc nk_font_atlas_add_from_file*(atlas; path: cstring; h: cfloat; cfg): ptr Font
{.pop.}

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
