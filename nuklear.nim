{.emit: """
#define NK_IMPLEMENTATION
#include "nuklear.h"
""".}

import nuklear/[colour, drawing, font, input, layout, properties, style, text, tree, widget, window, context, common]
export          colour, drawing, font, input, layout, properties, style, text, tree, widget, window, context, common

when defined NkIncludeDefaultAllocator:
    {.passC: "-DNK_INCLUDE_DEFAULT_ALLOCATOR".}
    proc nk_init_default*(ctx: ptr NkContext; font: ptr NkUserFont): bool {.importc: "nk_init_default".}

proc nk_init_fixed*(ctx: ptr NkContext; mem: pointer; sz: uint; font: ptr NkUserFont): bool                  {.importc: "nk_init_fixed" .}
proc nk_init*(ctx: ptr NkContext; allocator: ptr NkAllocator; font: ptr NkUserFont): bool                    {.importc: "nk_init"       .}
proc nk_init_custom*(ctx: ptr NkContext; cmds: ptr NkBuffer; pool: ptr NkBuffer; font: ptr NkUserFont): bool {.importc: "nk_init_custom".}
proc nk_clear*(ctx: ptr NkContext)                                                                           {.importc: "nk_clear"      .}
proc nk_free*(ctx: ptr NkContext)                                                                            {.importc: "nk_free"       .}

when defined NkIncludeCommandUserData:
    {.passC: "-DNK_INCLUDE_COMMAND_USER_DATA".}
    proc nk_set_user_data*(ctx: ptr NkContext; handle: NkHandle) {.importc: "nk_set_user_data".}









# List view
# struct nk_list_view {
# /* public: */
#     int begin, end, count;
# /* private: */
#     int total_height;
#     struct nk_context *ctx;
#     nk_uint *scroll_pointer;
#     nk_uint scroll_value;
# };
# NK_API nk_bool nk_list_view_begin(struct nk_context*, struct nk_list_view *out, const char *id, nk_flags, int row_height, int row_count);
# NK_API void nk_list_view_end(struct nk_list_view*);

# Contextual
# NK_API nk_bool nk_contextual_begin(struct nk_context*, nk_flags, struct nk_vec2, struct nk_rect trigger_bounds);
# NK_API nk_bool nk_contextual_item_text(struct nk_context*, const char*, int,nk_flags align);
# NK_API nk_bool nk_contextual_item_label(struct nk_context*, const char*, nk_flags align);
# NK_API nk_bool nk_contextual_item_image_label(struct nk_context*, struct nk_image, const char*, nk_flags alignment);
# NK_API nk_bool nk_contextual_item_image_text(struct nk_context*, struct nk_image, const char*, int len, nk_flags alignment);
# NK_API nk_bool nk_contextual_item_symbol_label(struct nk_context*, enum nk_symbol_type, const char*, nk_flags alignment);
# NK_API nk_bool nk_contextual_item_symbol_text(struct nk_context*, enum nk_symbol_type, const char*, int, nk_flags alignment);
# NK_API void nk_contextual_close(struct nk_context*);
# NK_API void nk_contextual_end(struct nk_context*);


# /* =============================================================================
#  *
#  *                                  IMAGE
#  *
#  * ============================================================================= */
# NK_API nk_handle nk_handle_ptr(void*);
# NK_API nk_handle nk_handle_id(int);
# NK_API struct nk_image nk_image_handle(nk_handle);
# NK_API struct nk_image nk_image_ptr(void*);
# NK_API struct nk_image nk_image_id(int);
# NK_API nk_bool nk_image_is_subimage(const struct nk_image* img);
# NK_API struct nk_image nk_subimage_ptr(void*, nk_ushort w, nk_ushort h, struct nk_rect sub_region);
# NK_API struct nk_image nk_subimage_id(int, nk_ushort w, nk_ushort h, struct nk_rect sub_region);
# NK_API struct nk_image nk_subimage_handle(nk_handle, nk_ushort w, nk_ushort h, struct nk_rect sub_region);
# /* =============================================================================
#  *
#  *                                  9-SLICE
#  *
#  * ============================================================================= */
# NK_API struct nk_nine_slice nk_nine_slice_handle(nk_handle, nk_ushort l, nk_ushort t, nk_ushort r, nk_ushort b);
# NK_API struct nk_nine_slice nk_nine_slice_ptr(void*, nk_ushort l, nk_ushort t, nk_ushort r, nk_ushort b);
# NK_API struct nk_nine_slice nk_nine_slice_id(int, nk_ushort l, nk_ushort t, nk_ushort r, nk_ushort b);
# NK_API int nk_nine_slice_is_sub9slice(const struct nk_nine_slice* img);
# NK_API struct nk_nine_slice nk_sub9slice_ptr(void*, nk_ushort w, nk_ushort h, struct nk_rect sub_region, nk_ushort l, nk_ushort t, nk_ushort r, nk_ushort b);
# NK_API struct nk_nine_slice nk_sub9slice_id(int, nk_ushort w, nk_ushort h, struct nk_rect sub_region, nk_ushort l, nk_ushort t, nk_ushort r, nk_ushort b);
# NK_API struct nk_nine_slice nk_sub9slice_handle(nk_handle, nk_ushort w, nk_ushort h, struct nk_rect sub_region, nk_ushort l, nk_ushort t, nk_ushort r, nk_ushort b);
# /* =============================================================================
#  *
#  *                                  MATH
#  *
#  * ============================================================================= */
# NK_API nk_hash nk_murmur_hash(const void *key, int len, nk_hash seed);
# NK_API void nk_triangle_from_direction(struct nk_vec2 *result, struct nk_rect r, float pad_x, float pad_y, enum nk_heading);

# NK_API struct nk_vec2 nk_vec2(float x, float y);
# NK_API struct nk_vec2 nk_vec2i(int x, int y);
# NK_API struct nk_vec2 nk_vec2v(const float *xy);
# NK_API struct nk_vec2 nk_vec2iv(const int *xy);

# NK_API struct nk_rect nk_get_null_rect(void);
# NK_API struct nk_rect nk_rect(float x, float y, float w, float h);
# NK_API struct nk_rect nk_recti(int x, int y, int w, int h);
# NK_API struct nk_rect nk_recta(struct nk_vec2 pos, struct nk_vec2 size);
# NK_API struct nk_rect nk_rectv(const float *xywh);
# NK_API struct nk_rect nk_rectiv(const int *xywh);
# NK_API struct nk_vec2 nk_rect_pos(struct nk_rect);
# NK_API struct nk_vec2 nk_rect_size(struct nk_rect);
# /* =============================================================================
#  *
#  *                                  STRING
#  *
#  * ============================================================================= */
# NK_API int nk_strlen(const char *str);
# NK_API int nk_stricmp(const char *s1, const char *s2);
# NK_API int nk_stricmpn(const char *s1, const char *s2, int n);
# NK_API int nk_strtoi(const char *str, const char **endptr);
# NK_API float nk_strtof(const char *str, const char **endptr);
# #ifndef NK_STRTOD
# #define NK_STRTOD nk_strtod
# NK_API double nk_strtod(const char *str, const char **endptr);
# #endif
# NK_API int nk_strfilter(const char *text, const char *regexp);
# NK_API int nk_strmatch_fuzzy_string(char const *str, char const *pattern, int *out_score);
# NK_API int nk_strmatch_fuzzy_text(const char *txt, int txt_len, const char *pattern, int *out_score);
# /* =============================================================================
#  *
#  *                                  UTF-8
#  *
#  * ============================================================================= */
# NK_API int nk_utf_decode(const char*, nk_rune*, int);
# NK_API int nk_utf_encode(nk_rune, char*, int);
# NK_API int nk_utf_len(const char*, int byte_len);
# NK_API const char* nk_utf_at(const char *buffer, int length, int index, nk_rune *unicode, int *len);



# /* ==============================================================
#  *
#  *                          STRING
#  *
#  * ===============================================================*/
# /*  Basic string buffer which is only used in context with the text editor
#  *  to manage and manipulate dynamic or fixed size string content. This is _NOT_
#  *  the default string handling method. The only instance you should have any contact
#  *  with this API is if you interact with an `nk_text_edit` object inside one of the
#  *  copy and paste functions and even there only for more advanced cases. */
# struct nk_str {
#     struct nk_buffer buffer;
#     int len; /* in codepoints/runes/glyphs */
# };

# #ifdef NK_INCLUDE_DEFAULT_ALLOCATOR
# NK_API void nk_str_init_default(struct nk_str*);
# #endif
# NK_API void nk_str_init(struct nk_str*, const struct nk_allocator*, nk_size size);
# NK_API void nk_str_init_fixed(struct nk_str*, void *memory, nk_size size);
# NK_API void nk_str_clear(struct nk_str*);
# NK_API void nk_str_free(struct nk_str*);

# NK_API int nk_str_append_text_char(struct nk_str*, const char*, int);
# NK_API int nk_str_append_str_char(struct nk_str*, const char*);
# NK_API int nk_str_append_text_utf8(struct nk_str*, const char*, int);
# NK_API int nk_str_append_str_utf8(struct nk_str*, const char*);
# NK_API int nk_str_append_text_runes(struct nk_str*, const nk_rune*, int);
# NK_API int nk_str_append_str_runes(struct nk_str*, const nk_rune*);

# NK_API int nk_str_insert_at_char(struct nk_str*, int pos, const char*, int);
# NK_API int nk_str_insert_at_rune(struct nk_str*, int pos, const char*, int);

# NK_API int nk_str_insert_text_char(struct nk_str*, int pos, const char*, int);
# NK_API int nk_str_insert_str_char(struct nk_str*, int pos, const char*);
# NK_API int nk_str_insert_text_utf8(struct nk_str*, int pos, const char*, int);
# NK_API int nk_str_insert_str_utf8(struct nk_str*, int pos, const char*);
# NK_API int nk_str_insert_text_runes(struct nk_str*, int pos, const nk_rune*, int);
# NK_API int nk_str_insert_str_runes(struct nk_str*, int pos, const nk_rune*);

# NK_API void nk_str_remove_chars(struct nk_str*, int len);
# NK_API void nk_str_remove_runes(struct nk_str *str, int len);
# NK_API void nk_str_delete_chars(struct nk_str*, int pos, int len);
# NK_API void nk_str_delete_runes(struct nk_str*, int pos, int len);

# NK_API char *nk_str_at_char(struct nk_str*, int pos);
# NK_API char *nk_str_at_rune(struct nk_str*, int pos, nk_rune *unicode, int *len);
# NK_API nk_rune nk_str_rune_at(const struct nk_str*, int pos);
# NK_API const char *nk_str_at_char_const(const struct nk_str*, int pos);
# NK_API const char *nk_str_at_const(const struct nk_str*, int pos, nk_rune *unicode, int *len);

# NK_API char *nk_str_get(struct nk_str*);
# NK_API const char *nk_str_get_const(const struct nk_str*);
# NK_API int nk_str_len(struct nk_str*);
# NK_API int nk_str_len_char(struct nk_str*);


# /*==============================================================
#  *                          STACK
#  * =============================================================*/
# /*/// ### Stack
# /// The style modifier stack can be used to temporarily change a
# /// property inside `nk_style`. For example if you want a special
# /// red button you can temporarily push the old button color onto a stack
# /// draw the button with a red color and then you just pop the old color
# /// back from the stack:
# ///
# ///     nk_style_push_style_item(ctx, &ctx->style.button.normal, nk_style_item_color(nk_rgb(255,0,0)));
# ///     nk_style_push_style_item(ctx, &ctx->style.button.hover, nk_style_item_color(nk_rgb(255,0,0)));
# ///     nk_style_push_style_item(ctx, &ctx->style.button.active, nk_style_item_color(nk_rgb(255,0,0)));
# ///     nk_style_push_vec2(ctx, &cx->style.button.padding, nk_vec2(2,2));
# ///
# ///     nk_button(...);
# ///
# ///     nk_style_pop_style_item(ctx);
# ///     nk_style_pop_style_item(ctx);
# ///     nk_style_pop_style_item(ctx);
# ///     nk_style_pop_vec2(ctx);
# ///
# /// Nuklear has a stack for style_items, float properties, vector properties,
# /// flags, colors, fonts and for button_behavior. Each has it's own fixed size stack
# /// which can be changed at compile time.
#  */
# #ifndef NK_BUTTON_BEHAVIOR_STACK_SIZE
# #define NK_BUTTON_BEHAVIOR_STACK_SIZE 8
# #endif

# #ifndef NK_FONT_STACK_SIZE
# #define NK_FONT_STACK_SIZE 8
# #endif

# #ifndef NK_STYLE_ITEM_STACK_SIZE
# #define NK_STYLE_ITEM_STACK_SIZE 16
# #endif

# #ifndef NK_FLOAT_STACK_SIZE
# #define NK_FLOAT_STACK_SIZE 32
# #endif

# #ifndef NK_VECTOR_STACK_SIZE
# #define NK_VECTOR_STACK_SIZE 16
# #endif

# #ifndef NK_FLAGS_STACK_SIZE
# #define NK_FLAGS_STACK_SIZE 32
# #endif

# #ifndef NK_COLOR_STACK_SIZE
# #define NK_COLOR_STACK_SIZE 32
# #endif

# #define NK_CONFIGURATION_STACK_TYPE(prefix, name, type)\
#     struct nk_config_stack_##name##_element {\
#         prefix##_##type *address;\
#         prefix##_##type old_value;\
#     }
# #define NK_CONFIG_STACK(type,size)\
#     struct nk_config_stack_##type {\
#         int head;\
#         struct nk_config_stack_##type##_element elements[size];\
#     }

# #define nk_float float
# NK_CONFIGURATION_STACK_TYPE(struct nk, style_item, style_item);
# NK_CONFIGURATION_STACK_TYPE(nk ,float, float);
# NK_CONFIGURATION_STACK_TYPE(struct nk, vec2, vec2);
# NK_CONFIGURATION_STACK_TYPE(nk ,flags, flags);
# NK_CONFIGURATION_STACK_TYPE(struct nk, color, color);
# NK_CONFIGURATION_STACK_TYPE(const struct nk, user_font, user_font*);
# NK_CONFIGURATION_STACK_TYPE(enum nk, button_behavior, button_behavior);

# NK_CONFIG_STACK(style_item, NK_STYLE_ITEM_STACK_SIZE);
# NK_CONFIG_STACK(float, NK_FLOAT_STACK_SIZE);
# NK_CONFIG_STACK(vec2, NK_VECTOR_STACK_SIZE);
# NK_CONFIG_STACK(flags, NK_FLAGS_STACK_SIZE);
# NK_CONFIG_STACK(color, NK_COLOR_STACK_SIZE);
# NK_CONFIG_STACK(user_font, NK_FONT_STACK_SIZE);
# NK_CONFIG_STACK(button_behavior, NK_BUTTON_BEHAVIOR_STACK_SIZE);

# struct nk_configuration_stacks {
#     struct nk_config_stack_style_item style_items;
#     struct nk_config_stack_float floats;
#     struct nk_config_stack_vec2 vectors;
#     struct nk_config_stack_flags flags;
#     struct nk_config_stack_color colors;
#     struct nk_config_stack_user_font fonts;
#     struct nk_config_stack_button_behavior button_behaviors;
# };
