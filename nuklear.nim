{.emit: """
#define NK_IMPLEMENTATION
#define NK_INCLUDE_FIXED_TYPES
#include "nuklear.h"
""".}

import nuklear/[drawing, font, input, layout, properties, style, text, tree, widget, window, stack, context, common]
export          drawing, font, input, layout, properties, style, text, tree, widget, window, stack, context
export common except Rect, RectI, Vec, VecI, Colour, ColourF

when defined NkIncludeCommandUserData:
    proc nk_set_user_data*(ctx: ptr Context; handle: Handle) {.importc.}

{.emit: &"""static_assert(sizeof(struct nk_context) == {sizeof(Context)}, "sizeof context");""".}
