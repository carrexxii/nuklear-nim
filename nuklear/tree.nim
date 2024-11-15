import common

using
    ctx  : ptr Context
    title: cstring
    kind : TreeKind

proc nk_tree_push_hashed*(ctx; kind; title; init_state: CollapseState; hash: cstring; len, seed: cint): bool                   {.importc: "nk_tree_push_hashed"      .}
proc nk_tree_image_push_hashed*(ctx; kind; img: Image; title; init_state: CollapseState; hash: cstring; len, seed: cint): bool {.importc: "nk_tree_image_push_hashed".}
proc nk_tree_pop*(ctx)                                                                                                         {.importc: "nk_tree_pop"              .}

proc nk_tree_state_push*(ctx; kind; title; state: ptr CollapseState): bool       {.importc: "nk_tree_state_push"      .}
proc nk_tree_state_image_push*(ctx; kind; title; state: ptr CollapseState): bool {.importc: "nk_tree_state_image_push".}
proc nk_tree_state_pop*(ctx)                                                     {.importc: "nk_tree_state_pop"       .}

proc nk_tree_element_push_hashed*(ctx; kind; title; state: CollapseState; selected: ptr bool; hash: cstring; len, seed: cint): bool                   {.importc: "nk_tree_element_push_hashed"      .}
proc nk_tree_element_image_push_hashed*(ctx; kind; img: Image; title; state: CollapseState; selected: ptr bool; hash: cstring; len, seed: cint): bool {.importc: "nk_tree_element_image_push_hashed".}
proc nk_tree_element_pop*(ctx)                                                                                                                        {.importc: "nk_tree_element_pop"              .}

# #define nk_tree_push(ctx, type, title, state) nk_tree_push_hashed(ctx, type, title, state, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),__LINE__)
# #define nk_tree_push_id(ctx, type, title, state, id) nk_tree_push_hashed(ctx, type, title, state, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),id)
# #define nk_tree_image_push(ctx, type, img, title, state) nk_tree_image_push_hashed(ctx, type, img, title, state, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),__LINE__)
# #define nk_tree_image_push_id(ctx, type, img, title, state, id) nk_tree_image_push_hashed(ctx, type, img, title, state, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),id)
# #define nk_tree_element_push_id(ctx, type, title, state, sel, id) nk_tree_element_push_hashed(ctx, type, title, state, sel, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),id)
# #define nk_tree_element_push(ctx, type, title, state, sel) nk_tree_element_push_hashed(ctx, type, title, state, sel, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),__LINE__)
