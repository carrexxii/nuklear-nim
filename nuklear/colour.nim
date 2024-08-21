# NK_API struct nk_color nk_rgb(int r, int g, int b);
# NK_API struct nk_color nk_rgb_iv(const int *rgb);
# NK_API struct nk_color nk_rgb_bv(const nk_byte* rgb);
# NK_API struct nk_color nk_rgb_f(float r, float g, float b);
# NK_API struct nk_color nk_rgb_fv(const float *rgb);
# NK_API struct nk_color nk_rgb_cf(struct nk_colorf c);
# NK_API struct nk_color nk_rgb_hex(const char *rgb);
# NK_API struct nk_color nk_rgb_factor(struct nk_color col, const float factor);

# NK_API struct nk_color nk_rgba(int r, int g, int b, int a);
# NK_API struct nk_color nk_rgba_u32(nk_uint);
# NK_API struct nk_color nk_rgba_iv(const int *rgba);
# NK_API struct nk_color nk_rgba_bv(const nk_byte *rgba);
# NK_API struct nk_color nk_rgba_f(float r, float g, float b, float a);
# NK_API struct nk_color nk_rgba_fv(const float *rgba);
# NK_API struct nk_color nk_rgba_cf(struct nk_colorf c);
# NK_API struct nk_color nk_rgba_hex(const char *rgb);

# NK_API struct nk_colorf nk_hsva_colorf(float h, float s, float v, float a);
# NK_API struct nk_colorf nk_hsva_colorfv(float *c);
# NK_API void nk_colorf_hsva_f(float *out_h, float *out_s, float *out_v, float *out_a, struct nk_colorf in);
# NK_API void nk_colorf_hsva_fv(float *hsva, struct nk_colorf in);

# NK_API struct nk_color nk_hsv(int h, int s, int v);
# NK_API struct nk_color nk_hsv_iv(const int *hsv);
# NK_API struct nk_color nk_hsv_bv(const nk_byte *hsv);
# NK_API struct nk_color nk_hsv_f(float h, float s, float v);
# NK_API struct nk_color nk_hsv_fv(const float *hsv);

# NK_API struct nk_color nk_hsva(int h, int s, int v, int a);
# NK_API struct nk_color nk_hsva_iv(const int *hsva);
# NK_API struct nk_color nk_hsva_bv(const nk_byte *hsva);
# NK_API struct nk_color nk_hsva_f(float h, float s, float v, float a);
# NK_API struct nk_color nk_hsva_fv(const float *hsva);

# /* color (conversion nuklear --> user) */
# NK_API void nk_color_f(float *r, float *g, float *b, float *a, struct nk_color);
# NK_API void nk_color_fv(float *rgba_out, struct nk_color);
# NK_API struct nk_colorf nk_color_cf(struct nk_color);
# NK_API void nk_color_d(double *r, double *g, double *b, double *a, struct nk_color);
# NK_API void nk_color_dv(double *rgba_out, struct nk_color);

# NK_API nk_uint nk_color_u32(struct nk_color);
# NK_API void nk_color_hex_rgba(char *output, struct nk_color);
# NK_API void nk_color_hex_rgb(char *output, struct nk_color);

# NK_API void nk_color_hsv_i(int *out_h, int *out_s, int *out_v, struct nk_color);
# NK_API void nk_color_hsv_b(nk_byte *out_h, nk_byte *out_s, nk_byte *out_v, struct nk_color);
# NK_API void nk_color_hsv_iv(int *hsv_out, struct nk_color);
# NK_API void nk_color_hsv_bv(nk_byte *hsv_out, struct nk_color);
# NK_API void nk_color_hsv_f(float *out_h, float *out_s, float *out_v, struct nk_color);
# NK_API void nk_color_hsv_fv(float *hsv_out, struct nk_color);

# NK_API void nk_color_hsva_i(int *h, int *s, int *v, int *a, struct nk_color);
# NK_API void nk_color_hsva_b(nk_byte *h, nk_byte *s, nk_byte *v, nk_byte *a, struct nk_color);
# NK_API void nk_color_hsva_iv(int *hsva_out, struct nk_color);
# NK_API void nk_color_hsva_bv(nk_byte *hsva_out, struct nk_color);
# NK_API void nk_color_hsva_f(float *out_h, float *out_s, float *out_v, float *out_a, struct nk_color);
# NK_API void nk_color_hsva_fv(float *hsva_out, struct nk_color);
