{.emit: """
#define NK_IMPLEMENTATION
#include "nuklear.h"
""".}

import nuklear/[drawing, font, input, layout, properties, style, text, tree, widget, window, stack, context, common]
export          drawing, font, input, layout, properties, style, text, tree, widget, window, stack, context, common

when defined NkIncludeCommandUserData:
    proc nk_set_user_data*(ctx: ptr Context; handle: Handle) {.importc: "nk_set_user_data".}
