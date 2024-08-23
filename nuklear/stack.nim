import common, style, font

# #define NK_CONFIG_STACK(type,size)\
#     struct nk_config_stack_##type {\
#         int head;\
#         struct nk_config_stack_##type##_element elements[size];\
#     }

# NK_CONFIG_STACK(style_item, NK_STYLE_ITEM_STACK_SIZE);
# NK_CONFIG_STACK(float, NK_FLOAT_STACK_SIZE);
# NK_CONFIG_STACK(vec2, NK_VECTOR_STACK_SIZE);
# NK_CONFIG_STACK(flags, NK_FLAGS_STACK_SIZE);
# NK_CONFIG_STACK(color, NK_COLOR_STACK_SIZE);
# NK_CONFIG_STACK(user_font, NK_FONT_STACK_SIZE);
# NK_CONFIG_STACK(button_behavior, NK_BUTTON_BEHAVIOR_STACK_SIZE);

type
    NkConfigurationStacks* = object
        style_items*   : NkConfigStackStyle
        floats*        : NkConfigStackFloat
        vectors*       : NkConfigStackVec2
        flags*         : NkConfigStackFlag
        colours*       : NkConfigStackColour
        user_fonts*    : NkConfigStackUserFont
        btn_behaviours*: NkConfigStackButtonBehaviour

    NkConfigStackStyle* = object
        head* : int32
        elems*: array[NkStyleItemStackSize, tuple[address: ptr NkStyleItem,
                                                  old_val: NkStyleItem]]
    NkConfigStackFloat* = object
        head* : int32
        elems*: array[NkFloatStackSize, tuple[address: ptr float32,
                                              old_val: float32]]
    NkConfigStackVec2* = object
        head* : int32
        elems*: array[NkVec2StackSize, tuple[address: ptr NkVec2,
                                             old_val: NkVec2]]
    NkConfigStackFlag* = object
        head* : int32
        elems*: array[NkFlagStackSize, tuple[address: ptr NkFlag,
                                             old_val: NkFlag]]
    NkConfigStackColour* = object
        head* : int32
        elems*: array[NkColourStackSize, tuple[address: ptr NkColour,
                                               old_val: NkColour]]
    NkConfigStackUserFont* = object
        head* : int32
        elems*: array[NkUserFontStackSize, tuple[address: ptr NkUserFont,
                                                 old_val: NkUserFont]]
    NkConfigStackButtonBehaviour* = object
        head* : int32
        elems*: array[NkButtonBehaviourStackSize, tuple[address: ptr NkButtonBehaviour,
                                                        old_val: NkButtonBehaviour]]
