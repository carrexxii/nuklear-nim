{.emit: """
#define NK_IMPLEMENTATION
#include "nuklear.h"
""".}

import nuklear/[drawing, font, input, layout, properties, style, text, tree, widget, window, stack, context, common]
export          drawing, font, input, layout, properties, style, text, tree, widget, window, stack, context, common

when defined NkIncludeCommandUserData:
    {.passC: "-DNK_INCLUDE_COMMAND_USER_DATA".}
    proc nk_set_user_data*(ctx: ptr NkContext; handle: NkHandle) {.importc: "nk_set_user_data".}
