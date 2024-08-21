import common

type NkTreeKind* {.size: sizeof(NkFlag).} = enum
    nkTreeNode
    nkTreeTab

using
    ctx  : pointer
    title: cstring

proc nk_tree_push_hashed*(ctx; kind: NkTreeKind; title; init_state: NkCollapseState; hash: cstring; len, seed: int32): bool                     {.importc: "nk_tree_push_hashed"      .}
proc nk_tree_image_push_hashed*(ctx; kind: NkTreeKind; img: NkImage; title; init_state: NkCollapseState; hash: cstring; len, seed: int32): bool {.importc: "nk_tree_image_push_hashed".}
proc nk_tree_pop*(ctx)                                                                                                                          {.importc: "nk_tree_pop"              .}

proc nk_tree_state_push*(ctx; kind: NkTreeKind; title; state: ptr NkCollapseState): bool       {.importc: "nk_tree_state_push"      .}
proc nk_tree_state_image_push*(ctx; kind: NkTreeKind; title; state: ptr NkCollapseState): bool {.importc: "nk_tree_state_image_push".}
proc nk_tree_state_pop*(ctx)                                                                   {.importc: "nk_tree_state_pop"       .}

proc nk_tree_element_push_hashed*(ctx; kind: NkTreeKind; title; state: NkCollapseState; selected: ptr bool; hash: cstring; len, seed: int32): bool                     {.importc: "nk_tree_element_push_hashed"      .}
proc nk_tree_element_image_push_hashed*(ctx; kind: NkTreeKind; img: NkImage; title; state: NkCollapseState; selected: ptr bool; hash: cstring; len, seed: int32): bool {.importc: "nk_tree_element_image_push_hashed".}
proc nk_tree_element_pop*(ctx)                                                                                                                                          {.importc: "nk_tree_element_pop"              .}

# #define nk_tree_push(ctx, type, title, state) nk_tree_push_hashed(ctx, type, title, state, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),__LINE__)
# #define nk_tree_push_id(ctx, type, title, state, id) nk_tree_push_hashed(ctx, type, title, state, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),id)
# #define nk_tree_image_push(ctx, type, img, title, state) nk_tree_image_push_hashed(ctx, type, img, title, state, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),__LINE__)
# #define nk_tree_image_push_id(ctx, type, img, title, state, id) nk_tree_image_push_hashed(ctx, type, img, title, state, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),id)
# #define nk_tree_element_push_id(ctx, type, title, state, sel, id) nk_tree_element_push_hashed(ctx, type, title, state, sel, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),id)
# #define nk_tree_element_push(ctx, type, title, state, sel) nk_tree_element_push_hashed(ctx, type, title, state, sel, NK_FILE_LINE,nk_strlen(NK_FILE_LINE),__LINE__)
