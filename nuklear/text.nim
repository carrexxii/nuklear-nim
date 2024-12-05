import common

using
    ctx: ptr Context
    str: cstring

proc nk_text*(ctx; str; len: cint; align: TextAlignment)                          {.importc: "nk_text"             .}
proc nk_text_coloured*(ctx; str; len: cint; align: TextAlignment; colour: Colour) {.importc: "nk_text_colored"     .}
proc nk_text_wrap*(ctx; str; len: cint)                                           {.importc: "nk_text_wrap"        .}
proc nk_text_wrap_coloured*(ctx; str; len: cint; colour: Colour)                  {.importc: "nk_text_wrap_colored".}

proc nk_label*(ctx; str; align: TextAlignment)                          {.importc: "nk_label"             .}
proc nk_label_coloured*(ctx; str; align: TextAlignment; colour: Colour) {.importc: "nk_label_colored"     .}
proc nk_label_wrap*(ctx; str)                                           {.importc: "nk_label_wrap"        .}
proc nk_label_coloured_wrap*(ctx; str: cstring; colour: Colour)         {.importc: "nk_label_colored_wrap".}

proc nk_image*(ctx; img: Image)                        {.importc: "nk_image"      .}
proc nk_image_colour*(ctx; img: Image; colour: Colour) {.importc: "nk_image_color".}

#[ -------------------------------------------------------------------- ]#

using
    ctx: var Context
    str: string

{.push inline.}

proc text*(ctx; str; align = taLeft)      = nk_text      ctx.addr, cstring str, cint str.len, align
proc text_wrap*(ctx; str; align = taLeft) = nk_text_wrap ctx.addr, cstring str, cint str.len
proc text*(ctx; str; align = taLeft; colour = Colour())      = nk_text_coloured      ctx.addr, cstring str, cint str.len, align, colour
proc text_wrap*(ctx; str; align = taLeft; colour = Colour()) = nk_text_wrap_coloured ctx.addr, cstring str, cint str.len, colour

proc label*(ctx; str; align = taLeft)      = nk_label      ctx.addr, cstring str, align
proc label_wrap*(ctx; str; align = taLeft) = nk_label_wrap ctx.addr, cstring str
proc label*(ctx; str; align = taLeft; colour: Colour)      = nk_label_coloured      ctx.addr, cstring str, align, colour
proc label_wrap*(ctx; str; align = taLeft; colour: Colour) = nk_label_coloured_wrap ctx.addr, cstring str, colour

{.pop.}

# NK_API nk_flags nk_edit_string(struct nk_context*, nk_flags, char *buffer, int *len, int max, nk_plugin_filter);
# NK_API nk_flags nk_edit_string_zero_terminated(struct nk_context*, nk_flags, char *buffer, int max, nk_plugin_filter);
# NK_API nk_flags nk_edit_buffer(struct nk_context*, nk_flags, struct nk_text_edit*, nk_plugin_filter);
# NK_API void nk_edit_focus(struct nk_context*, nk_flags flags);
# NK_API void nk_edit_unfocus(struct nk_context*);

# /* filter function */
# NK_API nk_bool nk_filter_default(const struct nk_text_edit*, nk_rune unicode);
# NK_API nk_bool nk_filter_ascii(const struct nk_text_edit*, nk_rune unicode);
# NK_API nk_bool nk_filter_float(const struct nk_text_edit*, nk_rune unicode);
# NK_API nk_bool nk_filter_decimal(const struct nk_text_edit*, nk_rune unicode);
# NK_API nk_bool nk_filter_hex(const struct nk_text_edit*, nk_rune unicode);
# NK_API nk_bool nk_filter_oct(const struct nk_text_edit*, nk_rune unicode);
# NK_API nk_bool nk_filter_binary(const struct nk_text_edit*, nk_rune unicode);

# /* text editor */
# #ifdef NK_INCLUDE_DEFAULT_ALLOCATOR
# NK_API void nk_textedit_init_default(struct nk_text_edit*);
# #endif
# NK_API void nk_textedit_init(struct nk_text_edit*, const struct nk_allocator*, nk_size size);
# NK_API void nk_textedit_init_fixed(struct nk_text_edit*, void *memory, nk_size size);
# NK_API void nk_textedit_free(struct nk_text_edit*);
# NK_API void nk_textedit_text(struct nk_text_edit*, const char*, int total_len);
# NK_API void nk_textedit_delete(struct nk_text_edit*, int where, int len);
# NK_API void nk_textedit_delete_selection(struct nk_text_edit*);
# NK_API void nk_textedit_select_all(struct nk_text_edit*);
# NK_API nk_bool nk_textedit_cut(struct nk_text_edit*);
# NK_API nk_bool nk_textedit_paste(struct nk_text_edit*, char const*, int len);
# NK_API void nk_textedit_undo(struct nk_text_edit*);
# NK_API void nk_textedit_redo(struct nk_text_edit*);
