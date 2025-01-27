import common

using
    ctx      : ptr Context
    str      : cstring
    text_edit: ptr TextEdit
    filter   : PluginFilter

{.push importc, cdecl.}
proc nk_text*(ctx; str; len: cint; align: TextAlignment)
proc nk_text_colored*(ctx; str; len: cint; align: TextAlignment; colour: Colour)
proc nk_text_wrap*(ctx; str; len: cint)
proc nk_text_wrap_colored*(ctx; str; len: cint; colour: Colour)

proc nk_label*(ctx; str; align: TextAlignment)
proc nk_label_colored*(ctx; str; align: TextAlignment; colour: Colour)
proc nk_label_wrap*(ctx; str)
proc nk_label_colored_wrap*(ctx; str: cstring; colour: Colour)

proc nk_image*(ctx; img: Image)
proc nk_image_colour*(ctx; img: Image; colour: Colour)

proc nk_edit_string*(ctx; flags: EditFlag; buf: ptr char; len: ptr cint; max: cint; filter): EditEventFlag
proc nk_edit_string_zero_terminated*(ctx; flags: EditFlag; buf: ptr char; max: cint; filter): EditEventFlag
proc nk_edit_buffer*(ctx; flags: EditFlag; text_edit; filter): EditEventFlag
proc nk_edit_focus*(ctx; flags: EditFlag)
proc nk_edit_unfocus*(ctx)

when defined NkIncludeDefaultAllocator:
    proc nk_textedit_init_default*(text_edit)
proc nk_textedit_init*(text_edit; allocator: ptr Allocator; sz: uint)
proc nk_textedit_init_fixed*(text_edit; mem: pointer; sz: uint)
proc nk_textedit_free*(text_edit)
proc nk_textedit_text*(text_edit; text: cstring; total_len: cint)
proc nk_textedit_delete*(text_edit; where, len: cint)
proc nk_textedit_delete_selection*(text_edit)
proc nk_textedit_select_all*(text_edit)
proc nk_textedit_cut*(text_edit): bool
proc nk_textedit_paste*(text_edit; text: cstring; len: cint): bool
proc nk_textedit_undo*(text_edit)
proc nk_textedit_redo*(text_edit)

proc nk_filter_default*(text_edit; unicode: Rune): bool
proc nk_filter_ascii*(text_edit; unicode: Rune): bool
proc nk_filter_float*(text_edit; unicode: Rune): bool
proc nk_filter_decimal*(text_edit; unicode: Rune): bool
proc nk_filter_hex*(text_edit; unicode: Rune): bool
proc nk_filter_oct*(text_edit; unicode: Rune): bool
proc nk_filter_binary*(text_edit; unicode: Rune): bool
{.pop.}

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

proc label*(ctx; str; align = taLeft)      = nk_text      ctx.addr, cstring str, cint str.len, align
proc label_wrap*(ctx; str; align = taLeft) = nk_text_wrap ctx.addr, cstring str, cint str.len
proc label*(ctx; str; r, g, b: uint8; a = 255'u8; align = taLeft) =
    let colour = Colour(r: r, g: g, b: b, a: a)
    nk_text_colored ctx.addr, cstring str, cint str.len, align, colour
proc label_wrap*(ctx; str; r, g, b: uint8; a = 255'u8; align = taLeft) =
    let colour = Colour(r: r, g: g, b: b, a: a)
    nk_text_wrap_colored ctx.addr, cstring str, cint str.len, colour

proc edit_string*(ctx; str: var string, max: int32; flags: EditFlag; filter = FilterDefault): EditEventFlag {.discardable.} =
    var len = cint str.len
    str.set_len max
    result = nk_edit_string(ctx.addr, flags, str[0].addr, len.addr, cint str.capacity, filter)
    str.set_len len

proc edit_simple*(ctx; str: var string; max = 64'i32; filter = FilterDefault): EditEventFlag {.discardable.} = edit_string ctx, str, max, ekSimple, filter
proc edit_field*(ctx; str: var string; max = 64'i32; filter = FilterDefault): EditEventFlag  {.discardable.} = edit_string ctx, str, max, ekField , filter
proc edit_box*(ctx; str: var string; max = 64'i32; filter = FilterDefault): EditEventFlag    {.discardable.} = edit_string ctx, str, max, ekBox   , filter
proc edit_editor*(ctx; str: var string; max = 64'i32; filter = FilterDefault): EditEventFlag {.discardable.} = edit_string ctx, str, max, ekEditor, filter

{.pop.}
