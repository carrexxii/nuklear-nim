import common

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
