import common, font, text, drawing

# NK_API void nk_style_default(struct nk_context*);
# NK_API void nk_style_from_table(struct nk_context*, const struct nk_color*);
# NK_API void nk_style_load_cursor(struct nk_context*, enum nk_style_cursor, const struct nk_cursor*);
# NK_API void nk_style_load_all_cursors(struct nk_context*, struct nk_cursor*);
# NK_API const char* nk_style_get_color_by_name(enum nk_style_colors);
# NK_API void nk_style_set_font(struct nk_context*, const struct nk_user_font*);
# NK_API nk_bool nk_style_set_cursor(struct nk_context*, enum nk_style_cursor);
# NK_API void nk_style_show_cursor(struct nk_context*);
# NK_API void nk_style_hide_cursor(struct nk_context*);

# NK_API nk_bool nk_style_push_font(struct nk_context*, const struct nk_user_font*);
# NK_API nk_bool nk_style_push_float(struct nk_context*, float*, float);
# NK_API nk_bool nk_style_push_vec2(struct nk_context*, struct nk_vec2*, struct nk_vec2);
# NK_API nk_bool nk_style_push_style_item(struct nk_context*, struct nk_style_item*, struct nk_style_item);
# NK_API nk_bool nk_style_push_flags(struct nk_context*, nk_flags*, nk_flags);
# NK_API nk_bool nk_style_push_color(struct nk_context*, struct nk_color*, struct nk_color);

# NK_API nk_bool nk_style_pop_font(struct nk_context*);
# NK_API nk_bool nk_style_pop_float(struct nk_context*);
# NK_API nk_bool nk_style_pop_vec2(struct nk_context*);
# NK_API nk_bool nk_style_pop_style_item(struct nk_context*);
# NK_API nk_bool nk_style_pop_flags(struct nk_context*);
# NK_API nk_bool nk_style_pop_color(struct nk_context*);

# NK_API struct nk_style_item nk_style_item_color(struct nk_color);
# NK_API struct nk_style_item nk_style_item_image(struct nk_image img);
# NK_API struct nk_style_item nk_style_item_nine_slice(struct nk_nine_slice slice);
# NK_API struct nk_style_item nk_style_item_hide(void);
