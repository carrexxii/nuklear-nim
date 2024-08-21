import common

type
    NkTextAlign* = enum
        nkTextAlignLeft    = 0x01
        nkTextAlignCentred = 0x02
        nkTextAlignRight   = 0x04
        nkTextAlignTop     = 0x08
        nkTextAlignMiddle  = 0x10
        nkTextAlignBottom  = 0x20

    NkTextAlignment* = enum A, B
    # NkTextAlignment* = enum
        # nkTextLeft    = nkTextAlignMiddle or nkTextAlignLeft
        # nkTextCentred = nkTextAlignMiddle or nkTextAlignCentred
        # nkTextRight   = nkTextAlignMiddle or nkTextAlignRight

#[ -------------------------------------------------------------------- ]#

type NkContext = object
using ctx: ptr NkContext

proc nk_text*(ctx; txt: cstring; len: int32; flags: NkFlag) {.importc: "nk_text".}
proc nk_text_coloured*(ctx; txt: cstring; len: int32; flags: NkFlag; colour: NkColour) {.importc: "nk_text_coloured".}
proc nk_text_wrap*(ctx; txt: cstring; len: int32) {.importc: "nk_text_wrap".}
proc nk_text_wrap_coloured*(ctx; txt: cstring; len: int32; colour: NkColour) {.importc: "nk_text_wrap_coloured".}

proc nk_label*(ctx; txt: cstring; align: NkTextAlignment) {.importc: "nk_label".}
proc nk_label_coloured*(ctx; txt: cstring; align: NkTextAlignment; colour: NkColour) {.importc: "nk_label_coloured".}
proc nk_label_wrap*(ctx; txt: cstring) {.importc: "nk_label_wrap".}
proc nk_label_coloured_wrap*(ctx; txt: cstring; colour: NkColour) {.importc: "nk_label_coloured_wrap".}

proc nk_image*(ctx; img: NkImage) {.importc: "nk_image".}
proc nk_image_colour*(ctx; img: NkImage; colour: NkColour) {.importc: "nk_image_colour".}

when defined NkIncludeStandardVarargs:
    {.passC: "-DNK_INCLUDE_STANDARD_VARARGS".}
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


# #ifndef NK_TEXTEDIT_UNDOSTATECOUNT
# #define NK_TEXTEDIT_UNDOSTATECOUNT     99
# #endif

# #ifndef NK_TEXTEDIT_UNDOCHARCOUNT
# #define NK_TEXTEDIT_UNDOCHARCOUNT      999
# #endif

# struct nk_text_edit;
# struct nk_clipboard {
#     nk_handle userdata;
#     nk_plugin_paste paste;
#     nk_plugin_copy copy;
# };

# struct nk_text_undo_record {
#    int where;
#    short insert_length;
#    short delete_length;
#    short char_storage;
# };

# struct nk_text_undo_state {
#    struct nk_text_undo_record undo_rec[NK_TEXTEDIT_UNDOSTATECOUNT];
#    nk_rune undo_char[NK_TEXTEDIT_UNDOCHARCOUNT];
#    short undo_point;
#    short redo_point;
#    short undo_char_point;
#    short redo_char_point;
# };

# enum nk_text_edit_type {
#     NK_TEXT_EDIT_SINGLE_LINE,
#     NK_TEXT_EDIT_MULTI_LINE
# };

# enum nk_text_edit_mode {
#     NK_TEXT_EDIT_MODE_VIEW,
#     NK_TEXT_EDIT_MODE_INSERT,
#     NK_TEXT_EDIT_MODE_REPLACE
# };

# struct nk_text_edit {
#     struct nk_clipboard clip;
#     struct nk_str string;
#     nk_plugin_filter filter;
#     struct nk_vec2 scrollbar;

#     int cursor;
#     int select_start;
#     int select_end;
#     unsigned char mode;
#     unsigned char cursor_at_end_of_line;
#     unsigned char initialized;
#     unsigned char has_preferred_x;
#     unsigned char single_line;
#     unsigned char active;
#     unsigned char padding1;
#     float preferred_x;
#     struct nk_text_undo_state undo;
# };

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
