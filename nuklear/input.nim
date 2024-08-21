import common

{.push size: sizeof(NkFlag).}
type
    NkKeyKind* = enum
        nkNone
        nkShift
        nkCtrl
        nkDel
        nkEnter
        nkTab
        nkBackspace
        nkCopy
        nkCut
        nkPaste
        nkUp
        nkDown
        nkLeft
        nkRight
        nkTextInsertMode
        nkTextReplaceMode
        nkTextResetMode
        nkTextLineStart
        nkTextLineEnd
        nkTextStart
        nkTextEnd
        nkTextUndo
        nkTextRedo
        nkTextSelectAll
        nkTextWordLeft
        nkTextWordRight
        nkScrollStart
        nkScrollEnd
        nkScrollDown
        nkScrollUp

    NkButton* = enum
        nkLeft
        nkMiddle
        nkRight
        nkDouble
{.pop.} # size: sizeof(cint)

type
    NkMouseButton* = object
        down*       : bool
        clicked*    : uint32
        clicked_pos*: NkVec2

    NkMouse* = object
        btns*: array[1 + int NkButton.high, NkMouseButton]
        pos* : NkVec2
        when defined NkButtonTriggerOnRelease:
            down_pos*: NkVec2
        prev*        : NkVec2
        delta*       : NkVec2
        scroll_delta*: NkVec2
        grab*        : uint8
        grabbed*     : uint8
        ungrab*      : uint8

    NkKey* = object
        down*   : bool
        clicked*: uint32

    NkKeyboard* = object
        keys*   : array[1 + int NkKeyKind.high, NkKey]
        txt*    : array[NkInputMax, char]
        txt_len*: int32

    NkInput* = object
        keyboard*: NkKeyboard
        mouse*   : NkMouse

#[ -------------------------------------------------------------------- ]#

using ctx: pointer

proc nk_input_begin*(ctx)                                          {.importc: "nk_input_begin"  .}
proc nk_input_motion*(ctx; x, y: int32)                            {.importc: "nk_input_motion" .}
proc nk_input_key*(ctx; key: NkKeyKind; down: bool)                {.importc: "nk_input_key"    .}
proc nk_input_button*(ctx; btn: NkButton; x, y: int32; down: bool) {.importc: "nk_input_button" .}
proc nk_input_scroll*(ctx; val: NkVec2)                            {.importc: "nk_input_scroll" .}
proc nk_input_char*(ctx; c: char)                                  {.importc: "nk_input_char"   .}
proc nk_input_glyph*(ctx; c: NkGlyph)                              {.importc: "nk_input_glyph"  .}
proc nk_input_unicode*(ctx; c: NkRune)                             {.importc: "nk_input_unicode".}
proc nk_input_end*(ctx)                                            {.importc: "nk_input_end"    .}

# NK_API nk_bool nk_input_has_mouse_click(const struct nk_input*, enum nk_buttons);
# NK_API nk_bool nk_input_has_mouse_click_in_rect(const struct nk_input*, enum nk_buttons, struct nk_rect);
# NK_API nk_bool nk_input_has_mouse_click_in_button_rect(const struct nk_input*, enum nk_buttons, struct nk_rect);
# NK_API nk_bool nk_input_has_mouse_click_down_in_rect(const struct nk_input*, enum nk_buttons, struct nk_rect, nk_bool down);
# NK_API nk_bool nk_input_is_mouse_click_in_rect(const struct nk_input*, enum nk_buttons, struct nk_rect);
# NK_API nk_bool nk_input_is_mouse_click_down_in_rect(const struct nk_input *i, enum nk_buttons id, struct nk_rect b, nk_bool down);
# NK_API nk_bool nk_input_any_mouse_click_in_rect(const struct nk_input*, struct nk_rect);
# NK_API nk_bool nk_input_is_mouse_prev_hovering_rect(const struct nk_input*, struct nk_rect);
# NK_API nk_bool nk_input_is_mouse_hovering_rect(const struct nk_input*, struct nk_rect);
# NK_API nk_bool nk_input_mouse_clicked(const struct nk_input*, enum nk_buttons, struct nk_rect);
# NK_API nk_bool nk_input_is_mouse_down(const struct nk_input*, enum nk_buttons);
# NK_API nk_bool nk_input_is_mouse_pressed(const struct nk_input*, enum nk_buttons);
# NK_API nk_bool nk_input_is_mouse_released(const struct nk_input*, enum nk_buttons);
# NK_API nk_bool nk_input_is_key_pressed(const struct nk_input*, enum nk_keys);
# NK_API nk_bool nk_input_is_key_released(const struct nk_input*, enum nk_keys);
# NK_API nk_bool nk_input_is_key_down(const struct nk_input*, enum nk_keys);
