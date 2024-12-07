import common

using
    ctx      : ptr Context
    str      : cstring
    text_edit: ptr TextEdit
    filter   : PluginFilter

proc nk_text*(ctx; str; len: cint; align: TextAlignment)                          {.importc: "nk_text"             .}
proc nk_text_coloured*(ctx; str; len: cint; align: TextAlignment; colour: Colour) {.importc: "nk_text_colored"     .}
proc nk_text_wrap*(ctx; str; len: cint)                                           {.importc: "nk_text_wrap"        .}
proc nk_text_wrap_coloured*(ctx; str; len: cint; colour: Colour)                  {.importc: "nk_text_wrap_colored".}

proc nk_label*(ctx; str; align: TextAlignment)                          {.importc: "nk_label"             .}
proc nk_label_coloured*(ctx; str; align: TextAlignment; colour: Colour) {.importc: "nk_label_colored"     .}
proc nk_label_wrap*(ctx; str)                                           {.importc: "nk_label_wrap"        .}
proc nk_label_coloured_wrap*(ctx; str: cstring; colour: Colour)         {.importc: "nk_label_colored_wrap".}

proc nk_image*(ctx; img: Image)                        {.importc: "nk_image"      .}
proc nk_image_colour*(ctx; img: Image; colour: Colour) {.importc: "nk_image_color".}

proc nk_filter_default*(text_edit; unicode: Rune): bool {.importc: "nk_filter_default".}
proc nk_filter_ascii*(text_edit; unicode: Rune): bool   {.importc: "nk_filter_ascii"  .}
proc nk_filter_float*(text_edit; unicode: Rune): bool   {.importc: "nk_filter_float"  .}
proc nk_filter_decimal*(text_edit; unicode: Rune): bool {.importc: "nk_filter_decimal".}
proc nk_filter_hex*(text_edit; unicode: Rune): bool     {.importc: "nk_filter_hex"    .}
proc nk_filter_oct*(text_edit; unicode: Rune): bool     {.importc: "nk_filter_oct"    .}
proc nk_filter_binary*(text_edit; unicode: Rune): bool  {.importc: "nk_filter_binary" .}

proc nk_edit_string*(ctx; flags: EditFlag; buf: ptr char; len: ptr cint; max: cint; filter): EditEventFlag  {.importc: "nk_edit_string"                .}
proc nk_edit_string_zero_terminated*(ctx; flags: EditFlag; buf: ptr char; max: cint; filter): EditEventFlag {.importc: "nk_edit_string_zero_terminated".}
proc nk_edit_buffer*(ctx; flags: EditFlag; text_edit; filter): EditEventFlag                                {.importc: "nk_edit_buffer"                .}
proc nk_edit_focus*(ctx; flags: EditFlag)                                                                   {.importc: "nk_edit_focus"                 .}
proc nk_edit_unfocus*(ctx)                                                                                  {.importc: "nk_edit_unfocus"               .}

when defined NkIncludeDefaultAllocator:
    proc nk_textedit_init_default*(text_edit) {.importc: "nk_textedit_init_default".}
proc nk_textedit_init*(text_edit; allocator: ptr Allocator; sz: uint) {.importc: "nk_textedit_init"            .}
proc nk_textedit_init_fixed*(text_edit; mem: pointer; sz: uint)       {.importc: "nk_textedit_init_fixed"      .}
proc nk_textedit_free*(text_edit)                                     {.importc: "nk_textedit_free"            .}
proc nk_textedit_text*(text_edit; text: cstring; total_len: cint)     {.importc: "nk_textedit_text"            .}
proc nk_textedit_delete*(text_edit; where, len: cint)                 {.importc: "nk_textedit_delete"          .}
proc nk_textedit_delete_selection*(text_edit)                         {.importc: "nk_textedit_delete_selection".}
proc nk_textedit_select_all*(text_edit)                               {.importc: "nk_textedit_select_all"      .}
proc nk_textedit_cut*(text_edit): bool                                {.importc: "nk_textedit_cut"             .}
proc nk_textedit_paste*(text_edit; text: cstring; len: cint): bool    {.importc: "nk_textedit_paste"           .}
proc nk_textedit_undo*(text_edit)                                     {.importc: "nk_textedit_undo"            .}
proc nk_textedit_redo*(text_edit)                                     {.importc: "nk_textedit_redo"            .}

#[ -------------------------------------------------------------------- ]#

using
    ctx: var Context
    str: string

{.push inline.}

let
    FilterDefault* = PluginFilter nk_filter_default
    FilterAscii*   = PluginFilter nk_filter_ascii
    FilterFloat*   = PluginFilter nk_filter_float
    FilterDecimal* = PluginFilter nk_filter_decimal
    FilterHex*     = PluginFilter nk_filter_hex
    FilterOct*     = PluginFilter nk_filter_oct
    FilterBinary*  = PluginFilter nk_filter_binary

proc text*(ctx; str; align = taLeft)      = nk_text      ctx.addr, cstring str, cint str.len, align
proc text_wrap*(ctx; str; align = taLeft) = nk_text_wrap ctx.addr, cstring str, cint str.len
proc text*(ctx; str; align = taLeft; colour = Colour())      = nk_text_coloured      ctx.addr, cstring str, cint str.len, align, colour
proc text_wrap*(ctx; str; align = taLeft; colour = Colour()) = nk_text_wrap_coloured ctx.addr, cstring str, cint str.len, colour

proc label*(ctx; str; align = taLeft)      = nk_label      ctx.addr, cstring str, align
proc label_wrap*(ctx; str; align = taLeft) = nk_label_wrap ctx.addr, cstring str
proc label*(ctx; str; align = taLeft; colour: Colour)      = nk_label_coloured      ctx.addr, cstring str, align, colour
proc label_wrap*(ctx; str; align = taLeft; colour: Colour) = nk_label_coloured_wrap ctx.addr, cstring str, colour

proc edit_string*(ctx; str: var string; flags: EditFlag; filter = FilterDefault): EditEventFlag {.discardable.} =
    nk_assert str.capacity > 0, "String cvapacity needs to be > 0"

    var len = cint str.len
    str.set_len str.capacity
    result = nk_edit_string(ctx.addr, flags, str[0].addr, len.addr, cint str.capacity, filter)
    str.set_len len

proc edit_simple*(ctx; str: var string; filter = FilterDefault): EditEventFlag {.discardable.} = edit_string ctx, str, ekSimple, filter
proc edit_field*(ctx; str: var string; filter = FilterDefault): EditEventFlag  {.discardable.} = edit_string ctx, str, ekField , filter
proc edit_box*(ctx; str: var string; filter = FilterDefault): EditEventFlag    {.discardable.} = edit_string ctx, str, ekBox   , filter
proc edit_editor*(ctx; str: var string; filter = FilterDefault): EditEventFlag {.discardable.} = edit_string ctx, str, ekEditor, filter

{.pop.}
