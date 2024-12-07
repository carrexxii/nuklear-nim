import common

using
    ctx  : ptr Context
    name : cstring
    title: cstring

proc nk_begin*(ctx; title; bounds: Rect; flags: PanelFlag): bool              {.importc: "nk_begin"       .}
proc nk_begin_titled*(ctx; name, title; bounds: Rect; flags: PanelFlag): bool {.importc: "nk_begin_titled".}
proc nk_end*(ctx)                                                             {.importc: "nk_end"         .}

proc nk_window_find*(ctx; name)                                          {.importc: "nk_window_find"                   .}
proc nk_window_get_bounds*(ctx): Rect                                    {.importc: "nk_window_get_bounds"             .}
proc nk_window_get_position*(ctx): Vec2                                  {.importc: "nk_window_get_position"           .}
proc nk_window_get_size*(ctx): Vec2                                      {.importc: "nk_window_get_size"               .}
proc nk_window_get_width*(ctx): cfloat                                   {.importc: "nk_window_get_width"              .}
proc nk_window_get_height*(ctx): cfloat                                  {.importc: "nk_window_get_height"             .}
proc nk_window_get_panel*(ctx): ptr Panel                                {.importc: "nk_window_get_panel"              .}
proc nk_window_get_content_region*(ctx): Rect                            {.importc: "nk_window_get_content_region"     .}
proc nk_window_get_content_region_min*(ctx): Vec2                        {.importc: "nk_window_get_content_region_min" .}
proc nk_window_get_content_region_max*(ctx): Vec2                        {.importc: "nk_window_get_content_region_max" .}
proc nk_window_get_content_region_size*(ctx): Vec2                       {.importc: "nk_window_get_content_region_size".}
proc nk_window_get_canvas*(ctx): ptr CommandBuffer                       {.importc: "nk_window_get_canvas"             .}
proc nk_window_get_scroll*(ctx; x_offset, y_offset: ptr uint32)          {.importc: "nk_window_get_scroll"             .}
proc nk_window_has_focus*(ctx): bool                                     {.importc: "nk_window_has_focus"              .}
proc nk_window_is_hovered*(ctx): bool                                    {.importc: "nk_window_is_hovered"             .}
proc nk_window_is_collapsed*(ctx; name): bool                            {.importc: "nk_window_is_collapsed"           .}
proc nk_window_is_closed*(ctx; name): bool                               {.importc: "nk_window_is_closed"              .}
proc nk_window_is_hidden*(ctx; name): bool                               {.importc: "nk_window_is_hidden"              .}
proc nk_window_is_active*(ctx; name): bool                               {.importc: "nk_window_is_active"              .}
proc nk_window_is_any_hovered*(ctx): bool                                {.importc: "nk_window_is_any_hovered"         .}
proc nk_window_is_any_active*(ctx): bool                                 {.importc: "nk_window_is_any_active"          .}
proc nk_window_set_bounds*(ctx; name; bounds: Rect)                      {.importc: "nk_window_set_bounds"             .}
proc nk_window_set_position*(ctx; name; pos: Vec2)                       {.importc: "nk_window_set_position"           .}
proc nk_window_set_size*(ctx; name; sz: Vec2)                            {.importc: "nk_window_set_size"               .}
proc nk_window_set_focus*(ctx; name)                                     {.importc: "nk_window_set_focus"              .}
proc nk_window_set_scroll*(ctx; name; x_offset, y_offset: uint32)        {.importc: "nk_window_set_scroll"             .}
proc nk_window_close*(ctx; name)                                         {.importc: "nk_window_close"                  .}
proc nk_window_collapse*(ctx; name; state: CollapseState)                {.importc: "nk_window_collapse"               .}
proc nk_window_collapse_if*(ctx; name; state: CollapseState; cond: cint) {.importc: "nk_window_collapse_if"            .}
proc nk_window_show*(ctx; name; state: ShowState)                        {.importc: "nk_window_show"                   .}
proc nk_window_show_if*(ctx; name; state: ShowState; cond: cint)         {.importc: "nk_window_show_if"                .}

proc nk_rule_horizontal*(ctx; colour: Colour; rounding: bool) {.importc: "nk_rule_horizontal".}

proc nk_group_begin*(ctx; title; flags: Flag): bool                                           {. importc: "nk_group_begin"                 .}
proc nk_group_begin_titled*(ctx; name, title; flags: Flag): bool                              {. importc: "nk_group_begin_titled"          .}
proc nk_group_end*(ctx)                                                                       {. importc: "nk_group_end"                   .}
proc nk_group_scrolled_offset_begin*(ctx; x_offset, y_offset: ptr uint32; title; flags: Flag) {. importc: "nk_group_scrolled_offset_begin" .}
proc nk_group_scrolled_begin*(ctx; offset: ptr Scroll; title; flags: Flag)                    {. importc: "nk_group_scrolled_begin"        .}
proc nk_group_scrolled_end*(ctx)                                                              {. importc: "nk_group_scrolled_end"          .}
proc nk_group_get_scroll*(ctx; id: cstring; x_offset, y_offset: ptr uint32)                   {. importc: "nk_group_get_scroll"            .}
proc nk_group_set_scroll*(ctx; id: cstring; x_offset, y_offset: uint32)                       {. importc: "nk_group_set_scroll"            .}

#[ -------------------------------------------------------------------- ]#

using ctx: var Context

{.push inline.}

proc begin*(ctx; bounds: Rect; flags: PanelFlag; name, title = ""): bool {.discardable.} =
    if title.len > 0:
        result = nk_begin(ctx.addr, cstring name, bounds, flags)
    else:
        result = nk_begin_titled(ctx.addr, cstring name, cstring title, bounds, flags)
    nk_assert result, &"Failed to begin Nuklear window \"{name}\"/\"{title}\" (bounds: {bounds}; flags: {flags})"

proc `end`*(ctx) = 
    nk_end ctx.addr

proc hr*(ctx; w: SomeNumber; h: SomeNumber = 1.5; colour = Colour(r: 112, g: 112, b: 112, a: 127); rounding = false) =
    ctx.row 1, h, w
    nk_rule_horizontal ctx.addr, colour, rounding

{.pop.}
