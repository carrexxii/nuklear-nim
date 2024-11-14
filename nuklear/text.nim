import bitgen, common

type TextAlign* = distinct uint32
TextAlign.gen_bit_ops(
    alignLeft, alignCentred, alignRight, alignTop,
    alignMiddle, alignBottom,
)

type
    TextAlignment* {.size: sizeof(Flag).} = enum
        alignmentLeft    = alignMiddle or alignLeft
        alignmentCentred = alignMiddle or alignCentred
        alignmentRight   = alignMiddle or alignRight

    TextEditKind* {.size: sizeof(Flag).} = enum
        editSingleLine
        editMultiline

    TextEditMode* {.size: sizeof(Flag).} = enum
        modeView
        modeInsert
        modeReplace

type
    TextEdit* = object
        clip*     : Clipboard
        str*      : String
        filter*   : PluginFilter
        scrollbar*: Vec2

        cursor*   : cint
        sel_start*: cint
        sel_end*  : cint
        mode*     : uint8

        cursor_at_end_of_line*: uint8
        initialized*          : uint8
        has_preferred_x*      : uint8
        single_line*          : uint8
        active*               : uint8
        _                     : uint8
        preferred_x*          : cfloat
        undo*                 : TextUndoState

    Clipboard* = object
        user_data*: Handle
        paste*    : PluginPaste
        copy*     : PluginCopy

    TextUndoRecord* = object
        where*       : cint
        ins_len*     : int16
        del_len*     : int16
        char_storage*: int16

    TextUndoState* = object
        undo_rec*       : array[NkTextEditUndoStateCount, TextUndoRecord]
        undo_char*      : array[NkTextEditUndoCharCount, Rune]
        undo_point*     : int16
        redo_point*     : int16
        undo_char_point*: int16
        redo_char_point*: int16

#[ -------------------------------------------------------------------- ]#

using
    ctx : pointer
    text: cstring

proc nk_text*(ctx; text; len: cint; flags: Flag)                          {.importc: "nk_text"              .}
proc nk_text_coloured*(ctx; text; len: cint; flags: Flag; colour: Colour) {.importc: "nk_text_coloured"     .}
proc nk_text_wrap*(ctx; text; len: cint)                                  {.importc: "nk_text_wrap"         .}
proc nk_text_wrap_coloured*(ctx; text; len: cint; colour: Colour)         {.importc: "nk_text_wrap_coloured".}

proc nk_label*(ctx; text; align: TextAlignment)                          {.importc: "nk_label"              .}
proc nk_label_coloured*(ctx; text; align: TextAlignment; colour: Colour) {.importc: "nk_label_coloured"     .}
proc nk_label_wrap*(ctx; text)                                           {.importc: "nk_label_wrap"         .}
proc nk_label_coloured_wrap*(ctx; text: cstring; colour: Colour)         {.importc: "nk_label_coloured_wrap".}

proc nk_image*(ctx; img: Image)                        {.importc: "nk_image"       .}
proc nk_image_colour*(ctx; img: Image; colour: Colour) {.importc: "nk_image_colour".}

when defined NkIncludeStandardVarargs:
    discard
    # NK_API void nk_labelf(struct nk_context*, nk_flags, NK_PRINTF_FORMAT_STRING const char*, ...) NK_PRINTF_VARARG_FUNC(3);
    # NK_API void nk_labelf_colored(struct nk_context*, nk_flags, struct nk_color, NK_PRINTF_FORMAT_STRING const char*,...) NK_PRINTF_VARARG_FUNC(4);
    # NK_API void nk_labelf_wrap(struct nk_context*, NK_PRINTF_FORMAT_STRING const char*,...) NK_PRINTF_VARARG_FUNC(2);
    # NK_API void nk_labelf_colored_wrap(struct nk_context*, struct nk_color, NK_PRINTF_FORMAT_STRING const char*,...) NK_PRINTF_VARARG_FUNC(3);
    # NK_API void nk_labelfv(struct nk_context*, nk_flags, NK_PRINTF_FORMAT_STRING const char*, va_list) NK_PRINTF_VALIST_FUNC(3);
    # NK_API void nk_labelfv_colored(struct nk_context*, nk_flags, struct nk_color, NK_PRINTF_FORMAT_STRING const char*, va_list) NK_PRINTF_VALIST_FUNC(4);
    # NK_API void nk_labelfv_wrap(struct nk_context*, NK_PRINTF_FORMAT_STRING const char*, va_list) NK_PRINTF_VALIST_FUNC(2);
    # NK_API void nk_labelfv_colored_wrap(struct nk_context*, struct nk_color, NK_PRINTF_FORMAT_STRING const char*, va_list) NK_PRINTF_VALIST_FUNC(3);
    # NK_API void nk_value_bool(struct nk_context*, const char *prefix, int);
    # NK_API void nk_value_int(struct nk_context*, const char *prefix, int);
    # NK_API void nk_value_uint(struct nk_context*, const char *prefix, unsigned int);
    # NK_API void nk_value_float(struct nk_context*, const char *prefix, float);
    # NK_API void nk_value_color_byte(struct nk_context*, const char *prefix, struct nk_color);
    # NK_API void nk_value_color_float(struct nk_context*, const char *prefix, struct nk_color);
    # NK_API void nk_value_color_hex(struct nk_context*, const char *prefix, struct nk_color);


# enum nk_edit_flags {
#     NK_EDIT_DEFAULT                 = 0,
#     NK_EDIT_READ_ONLY               = NK_FLAG(0),
#     NK_EDIT_AUTO_SELECT             = NK_FLAG(1),
#     NK_EDIT_SIG_ENTER               = NK_FLAG(2),
#     NK_EDIT_ALLOW_TAB               = NK_FLAG(3),
#     NK_EDIT_NO_CURSOR               = NK_FLAG(4),
#     NK_EDIT_SELECTABLE              = NK_FLAG(5),
#     NK_EDIT_CLIPBOARD               = NK_FLAG(6),
#     NK_EDIT_CTRL_ENTER_NEWLINE      = NK_FLAG(7),
#     NK_EDIT_NO_HORIZONTAL_SCROLL    = NK_FLAG(8),
#     NK_EDIT_ALWAYS_INSERT_MODE      = NK_FLAG(9),
#     NK_EDIT_MULTILINE               = NK_FLAG(10),
#     NK_EDIT_GOTO_END_ON_ACTIVATE    = NK_FLAG(11)
# };
# enum nk_edit_types {
#     NK_EDIT_SIMPLE  = NK_EDIT_ALWAYS_INSERT_MODE,
#     NK_EDIT_FIELD   = NK_EDIT_SIMPLE|NK_EDIT_SELECTABLE|NK_EDIT_CLIPBOARD,
#     NK_EDIT_BOX     = NK_EDIT_ALWAYS_INSERT_MODE| NK_EDIT_SELECTABLE| NK_EDIT_MULTILINE|NK_EDIT_ALLOW_TAB|NK_EDIT_CLIPBOARD,
#     NK_EDIT_EDITOR  = NK_EDIT_SELECTABLE|NK_EDIT_MULTILINE|NK_EDIT_ALLOW_TAB| NK_EDIT_CLIPBOARD
# };
# enum nk_edit_events {
#     NK_EDIT_ACTIVE      = NK_FLAG(0), /* edit widget is currently being modified */
#     NK_EDIT_INACTIVE    = NK_FLAG(1), /* edit widget is not active and is not being modified */
#     NK_EDIT_ACTIVATED   = NK_FLAG(2), /* edit widget went from state inactive to state active */
#     NK_EDIT_DEACTIVATED = NK_FLAG(3), /* edit widget went from state active to state inactive */
#     NK_EDIT_COMMITED    = NK_FLAG(4) /* edit widget has received an enter and lost focus */
# };
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
