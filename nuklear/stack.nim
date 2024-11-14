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
    ConfigurationStacks* = object
        style_items*   : ConfigStackStyle
        floats*        : ConfigStackFloat
        vectors*       : ConfigStackVec2
        flags*         : ConfigStackFlag
        colours*       : ConfigStackColour
        user_fonts*    : ConfigStackUserFont
        btn_behaviours*: ConfigStackButtonBehaviour

    ConfigStackStyle* = object
        head* : cint
        elems*: array[NkStyleItemStackSize, tuple[address: ptr StyleItem,
                                                  old_val: StyleItem]]
    ConfigStackFloat* = object
        head* : cint
        elems*: array[NkFloatStackSize, tuple[address: ptr cfloat,
                                              old_val: cfloat]]
    ConfigStackVec2* = object
        head* : cint
        elems*: array[NkVec2StackSize, tuple[address: ptr Vec2,
                                             old_val: Vec2]]
    ConfigStackFlag* = object
        head* : cint
        elems*: array[NkFlagStackSize, tuple[address: ptr Flag,
                                             old_val: Flag]]
    ConfigStackColour* = object
        head* : cint
        elems*: array[NkColourStackSize, tuple[address: ptr Colour,
                                               old_val: Colour]]
    ConfigStackUserFont* = object
        head* : cint
        elems*: array[NkUserFontStackSize, tuple[address: ptr UserFont,
                                                 old_val: UserFont]]
    ConfigStackButtonBehaviour* = object
        head* : cint
        elems*: array[NkButtonBehaviourStackSize, tuple[address: ptr ButtonBehaviour,
                                                        old_val: ButtonBehaviour]]
