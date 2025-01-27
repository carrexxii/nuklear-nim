import common

using
    ctx  : ptr Context
    title: cstring
    kind : TreeKind

{.push importc, cdecl.}
proc nk_tree_push_hashed*(ctx; kind; title; init_state: CollapseState; hash: cstring; len, seed: cint): bool
proc nk_tree_image_push_hashed*(ctx; kind; img: Image; title; init_state: CollapseState; hash: cstring; len, seed: cint): bool
proc nk_tree_pop*(ctx)

proc nk_tree_state_push*(ctx; kind; title; state: ptr CollapseState): bool
proc nk_tree_state_image_push*(ctx; kind; img: Image; title; state: ptr CollapseState): bool
proc nk_tree_state_pop*(ctx)

proc nk_tree_element_push_hashed*(ctx; kind; title; state: CollapseState; selected: ptr bool; hash: cstring; len, seed: cint): bool
proc nk_tree_element_image_push_hashed*(ctx; kind; img: Image; title; state: CollapseState; selected: ptr bool; hash: cstring; len, seed: cint): bool
proc nk_tree_element_pop*(ctx)
{.pop.}

using
    ctx  : var Context
    title: string

{.push inline.}

proc push_tree*(ctx; kind; title; state: var CollapseState): bool =
    nk_tree_state_push ctx.addr, kind, cstring title, state.addr
proc push_tree*(ctx; kind; img: Image; title; state: var CollapseState): bool =
    nk_tree_state_image_push ctx.addr, kind, img, cstring title, state.addr

template push_tree*(ctx; kind; title; init_state = csMinimised): bool =
    const
        info = instantiation_info()
        hash = cstring info.filename
        seed = cint info.line
    nk_tree_push_hashed ctx.addr, kind, cstring title, init_state, hash, hash.len, seed
template push_tree*(ctx; kind; img: Image; title; init_state = csMinimised): bool =
    const
        info = instantiation_info()
        hash = cstring info.filename
        seed = cint info.line
    nk_tree_image_push_hashed ctx.addr, kind, img, cstring title, init_state, hash, hash.len, seed

proc pop_tree*(ctx) = nk_tree_state_pop ctx.addr

{.pop.}
