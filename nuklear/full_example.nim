## https://floooh.github.io/sokol-html5/nuklear-sapp-ui.html

import std/[with, enumerate, strutils, times, math], ../nuklear

type
    MenuState = enum
        msDefault
        msWindows

    Menu2State = enum
        msNone
        msFile
        msEdit
        msView
        msChart

    WidgetOption = enum
        A
        B
        C

    ColourMode = enum
        cmRgb
        cmHsv

    ChartKind = enum
        cLine
        cHisto
        cMixed

var
    show_menu     = true
    show_titlebar = true
    show_border   = true
    allow_resize  = true
    movable       = true
    no_scrollbar  = false
    scale_on_left = false
    minimisable   = true

    header_align = shaRight
    show_about   = false

    menu_prog   = 60'u
    menu_slider = 10'i32
    menu_check  = true

    menu1_prog   = 40'u
    menu1_slider = 10'i32
    menu1_check  = true

    menu2_state: Menu2State = msNone

    w_checkbox: bool
    w_opt     : WidgetOption

    w_slider_int   = 5'i32
    w_slider_float = 5f
    w_prog         = 5'u
    w_prop_float   = 2f
    w_prop_int     = 2'i32
    w_prop_neg     = 2'i32

    w_range_float     = 0f..100f
    w_range_float_val = 50f
    w_range_int       = 0'i32..100'i32
    w_range_int_val   = 50'i32
    w_ratio           = [150f, 200]

    inactive_toggle = true

    selections1 = [false, false, true, false]
    selections2 = [[true , false, false, false],
                   [false, false, false, true ],
                   [false, false, true , false],
                   [false, true , false, false]]

    c_chart_selection = 8f
    c_current_weapon  = 0'i32
    c_check_values    = [false, false, false, false, false]
    c_position        = [0f, 0, 0]
    c_colour          = [130'u8, 50, 50, 255]
    c_colourf         = [0.509f, 0.705, 0.2, 1.0]
    c_prog_a          = 20u
    c_prog_b          = 40u
    c_prog_c          = 10u
    c_prog_d          = 90u
    c_weapons         = "Fist;Pistol;Shotgun;Plasma;BFG"
    c_weapons_arr     = c_weapons.split ';'
    c_mode            = cmRgb
    c_i               = 0'i32
    c_values          = [26f, 13, 30, 15, 25, 10, 20, 40, 12, 8, 22, 28, 5]

    time_selected = false
    date_selected = false
    sel_time: Time
    sel_date: DateTime

    i_text  : array[9, string]
    i_field : string
    i_box   : string
    i_editor: string

    chart_col_idx  = -1'i32
    chart_line_idx = -1'i32

    p_colour = [255'u8, 0, 0, 255]
    p_prog   = 40u
    p_slider = 10'i32
    p_select      : array[4, int32]
    p_active      : bool
    p_show_menu   : bool
    p_popup_active: bool

    g_w = 320'i32
    g_h = 320'i32
    g_titlebar : bool
    g_border   : bool
    g_scrollbar: bool
    g_selected : array[4, array[4, bool]]

    n_tab: ChartKind

proc full_ui_example*(ctx: var Context): bool =
    # hide_cursor ctx
    ctx.style.win.header.align = header_align

    var win_flags = wfNone
    if show_border  : win_flags.incl pfBorder
    if allow_resize : win_flags.incl pfScalable
    if movable      : win_flags.incl pfMovable
    if no_scrollbar : win_flags.incl pfNoScrollbar
    if scale_on_left: win_flags.incl pfScaleLeft
    if minimisable  : win_flags.incl pfMinimisable

    var edit_event: EditEventFlag
    if ctx.start((10.0, 25.0, 800.0, 600.0), PanelFlag win_flags, title = "Overview"):
        if show_menu:
            start_menubar ctx

            ctx.start_layout lfStatic, 5
            ctx.layout_push_row 85
            # Menu 1
            if ctx.start_menu("Menu", [120f, 200]):
                ctx.dynamic_row 1
                if ctx.menu_item("Hide", taLeft):
                    show_menu = false
                if ctx.menu_item("About", taLeft):
                    show_about = true

                with ctx:
                    progress_bar menu1_prog, 100, modifiable = true
                    slider       menu1_slider, 0..16
                    checkbox     "check", menu1_check
                stop_menu ctx
            # Menu 2
            if ctx.start_menu("Advanced", [200f, 600]):
                var state = if menu2_state == msFile: csMaximised else: csMinimised
                if ctx.push_tree(tkTab, "File", state):
                    menu2_state = msFile
                    if ctx.menu_item "New"  : echo "New"
                    if ctx.menu_item "Open" : echo "Open"
                    if ctx.menu_item "Save" : echo "Save"
                    if ctx.menu_item "Close": echo "Close"
                    if ctx.menu_item "Exit" : echo "Exit"
                    pop_tree ctx
                else:
                    menu2_state = if menu2_state == msFile: msNone else: menu2_state

                state = if menu2_state == msEdit: csMaximised else: csMinimised
                if ctx.push_tree(tkTab, "Edit", state):
                    menu2_state = msEdit
                    if ctx.menu_item "Copy"  : echo "Copy"
                    if ctx.menu_item "Delete": echo "Delete"
                    if ctx.menu_item "Cut"   : echo "Cut"
                    if ctx.menu_item "Paste" : echo "Paste"
                    pop_tree ctx
                else:
                    menu2_state = if menu2_state == msEdit: msNone else: menu2_state

                state = if menu2_state == msView: csMaximised else: csMinimised
                if ctx.push_tree(tkTab, "View", state):
                    menu2_state = msView
                    if ctx.menu_item "About"    : echo "About"
                    if ctx.menu_item "Options"  : echo "Options"
                    if ctx.menu_item "Customize": echo "Customize"
                    pop_tree ctx
                else:
                    menu2_state = if menu2_state == msView: msNone else: menu2_state

                state = if menu2_state == msChart: csMaximised else: csMinimised
                if ctx.push_tree(tkTab, "Chart", state):
                    menu2_state = msChart
                    const data = [26f, 13, 30, 15, 25, 10, 20, 40, 12, 8, 22, 28]
                    ctx.dynamic_row 1, 150
                    if ctx.start_chart(ckColumn, data.len, 0.0..50.0):
                        for d in data:
                            discard ctx.push_chart d
                        ctx.stop_chart
                    pop_tree ctx
                else:
                    menu2_state = if menu2_state == msChart: msNone else: menu2_state

                stop_menu ctx

            ctx.layout_push_row 70
            ctx.progress_bar menu_prog, 100, modifiable = true
            ctx.slider menu_slider, 0..16
            ctx.checkbox "Check", menu_check
            stop_menubar ctx

        if show_about:
            if ctx.start_popup(pkStatic, "About", [20f, 100, 300, 190]):
                ctx.dynamic_row 1, 20
                ctx.label "Nuklear"
                ctx.label "By Micha Mettke"
                ctx.label "Nuklear is licensed under the public domain license."
                stop_popup ctx
            else:
                show_about = false

        # Window flags
        if ctx.push_tree(tkTab, "Window"):
            ctx.dynamic_row 2, 30
            ctx.checkbox "Titlebar"    , show_titlebar
            ctx.checkbox "Menu"        , show_menu
            ctx.checkbox "Border"      , show_border
            ctx.checkbox "Resizable"   , allow_resize
            ctx.checkbox "Movable"     , movable
            ctx.checkbox "No Scrollbar", no_scrollbar
            ctx.checkbox "Minimizable" , minimisable
            ctx.checkbox "Scale Left"  , scale_on_left
            pop_tree ctx

        # Widgets
        if ctx.push_tree(tkTab, "Widgets"):
            if ctx.push_tree(tkNode, "Text"):
                ctx.dynamic_row 1, 20
                ctx.label "Label aligned left"  , align = taLeft
                ctx.label "Label aligned centre", align = taCentred
                ctx.label "Label aligned right" , align = taRight
                ctx.label "Blue text"  , 0, 0, 255
                ctx.label "Yellow text", 255, 255, 0

                ctx.static_row 1, 100, 200
                ctx.label_wrap "This is a very long line to hopefully get this text to be wrapped into multiple lines to show line wrapping"
                ctx.dynamic_row 1, 100
                ctx.label_wrap "This is another long text to show dynamic window changes on multiline text"

                pop_tree ctx

            if ctx.push_tree(tkNode, "Button"):
                ctx.static_row 3, 100, 30
                if ctx.button "Button":
                    echo "Button clicked"
                ctx.button_behaviour = bbRepeater
                if ctx.button "Repeater":
                    echo "Repeater pressed"
                ctx.button_behaviour = bbDefault
                discard ctx.button(0, 0, 255)

                ctx.static_row 8, 25, 25
                discard ctx.button skCircleSolid
                discard ctx.button skCircleOutline
                discard ctx.button skRectSolid
                discard ctx.button skRectOutline
                discard ctx.button skTriUp
                discard ctx.button skTriDown
                discard ctx.button skTriLeft
                discard ctx.button skTriRight

                ctx.static_row 2, 100, 30
                discard ctx.button(" prev ", skTriLeft, taRight)
                discard ctx.button(" next ", skTriRight)

                pop_tree ctx

            if ctx.push_tree(tkNode, "Basic"):
                ctx.static_row 1, 100, 30
                ctx.checkbox "Checkbox", w_checkbox

                # ctx.static_row 3, 80, 30
                ctx.dynamic_row 3
                w_opt = if ctx.option("Option A", w_opt == A): A else: w_opt
                w_opt = if ctx.option("Option B", w_opt == B): B else: w_opt
                w_opt = if ctx.option("Option C", w_opt == C): C else: w_opt

                ctx.layout_row lfStatic, 2, w_ratio, 30
                ctx.label "Slider int"
                ctx.slider w_slider_int, 0..10

                ctx.label "Slider float"
                ctx.slider w_slider_float, 0.0..5.0, 0.5
                ctx.label &"Progressbar: {w_prog}"
                ctx.progress_bar w_prog, 100, modifiable = true

                ctx.layout_row lfStatic, 2, w_ratio, 25
                ctx.label "Property float: "
                ctx.property "Float: ", w_prop_float, 0.0..64.0, 0.1, inc_per_px = 0.2
                ctx.label "Property int: "
                ctx.property "Int: ", w_prop_int, 0..100
                ctx.label "Property neg: "
                ctx.property "Neg: ", w_prop_neg, -10..10

                # Getting double free error with TCC
                when not defined tcc:
                    ctx.dynamic_row 1, 25
                    ctx.label "Range: "
                    ctx.dynamic_row 3, 25
                    ctx.property "#min: "  , w_range_float.a  , 0.0f..w_range_float.b, 1, 0.2
                    ctx.property "#float: ", w_range_float_val, w_range_float.a..w_range_float.b, 1, 0.2
                    ctx.property "#max: "  , w_range_float.b  , w_range_float.a..100.0f, 1, 0.2

                    ctx.property "#min: ", w_range_int.a  , int32.low..int32.high, 1, 10
                    ctx.property "#neg: ", w_range_int_val, w_range_int.a..w_range_int.b, 1, 10
                    ctx.property "#max: ", w_range_int.b  , w_range_int.a..int32.high, 1, 10

                pop_tree ctx

            if ctx.push_tree(tkNode, "Inactive"):
                ctx.dynamic_row 1, 30
                ctx.checkbox "Inactive", inactive_toggle

                ctx.static_row 1, 80, 30
                if inactive_toggle:
                    var btn = ctx.style.btn
                    ctx.style.btn.normal        = style_item(40, 40, 40)
                    ctx.style.btn.hover         = style_item(40, 40, 40)
                    ctx.style.btn.active        = style_item(40, 40, 40)
                    ctx.style.btn.border_colour = nk_colour(60, 60, 60)
                    ctx.style.btn.text_bg       = nk_colour(60, 60, 60)
                    ctx.style.btn.text_normal   = nk_colour(60, 60, 60)
                    ctx.style.btn.text_hover    = nk_colour(60, 60, 60)
                    ctx.style.btn.text_active   = nk_colour(60, 60, 60)
                    discard ctx.button "Button"
                    ctx.style.btn = btn
                elif ctx.button "Button":
                    echo "Button clicked"

                pop_tree ctx

            if ctx.push_tree(tkNode, "Selectable"):
                if ctx.push_tree(tkNode, "List"):
                    ctx.static_row 1, 100, 18
                    discard ctx.selectable("Selectable", selections1[0])
                    discard ctx.selectable("Selectable", selections1[1])
                    ctx.label "Not Selectable"
                    discard ctx.selectable("Selectable", selections1[2])
                    discard ctx.selectable("Selectable", selections1[3])

                    pop_tree ctx

                if ctx.push_tree(tkNode, "Grid"):
                    ctx.static_row 4, 50, 50
                    for (j, row) in enumerate mitems selections2:
                        for (i, cell) in enumerate mitems row:
                            discard ctx.selectable($j & $i, cell, align = taCentred)

                    pop_tree ctx

                pop_tree ctx

            if ctx.push_tree(tkNode, "Combo"):
                var sum: uint
                ctx.static_row 1, 300, 25
                ctx.combobox(c_weapons, ';', 5, c_current_weapon, 25, [200f, 200])

                if ctx.start_combobox(c_colour, [200f, 200]):
                    ctx.layout_row lfDynamic, 2, [0.15f, 0.85], 30
                    ctx.label "R: "; ctx.slider c_colour[0], 0..255, 5
                    ctx.label "G: "; ctx.slider c_colour[1], 0..255, 5
                    ctx.label "B: "; ctx.slider c_colour[2], 0..255, 5
                    ctx.label "A: "; ctx.slider c_colour[3], 0..255, 5
                    stop_combobox ctx

                let colour = [uint8 (255*c_colourf[0]), uint8 (255*c_colourf[1]), uint8 (255*c_colourf[2]), uint8 (255*c_colourf[3])]
                if ctx.start_combobox(colour, [200f, 400]):
                    ctx.dynamic_row 1, 120
                    discard ctx.colour_picker c_colourf

                    ctx.dynamic_row 2, 25
                    c_mode = if ctx.option("RGB", c_mode == cmRgb): cmRgb else: c_mode
                    c_mode = if ctx.option("HSV", c_mode == cmHsv): cmHsv else: c_mode

                    ctx.dynamic_row 1, 25
                    ctx.property "#R: ", c_colourf[0], 0.0..1.0, 0.01, 0.005
                    ctx.property "#G: ", c_colourf[1], 0.0..1.0, 0.01, 0.005
                    ctx.property "#B: ", c_colourf[2], 0.0..1.0, 0.01, 0.005
                    ctx.property "#A: ", c_colourf[3], 0.0..1.0, 0.01, 0.005

                    # TODO: HSV

                    stop_combobox ctx

                sum = c_prog_a + c_prog_b + c_prog_c + c_prog_d
                if ctx.start_combobox($sum, [200f, 200]):
                    ctx.dynamic_row 1, 30
                    ctx.progress_bar c_prog_a, 100, true
                    ctx.progress_bar c_prog_b, 100, true
                    ctx.progress_bar c_prog_c, 100, true
                    ctx.progress_bar c_prog_d, 100, true

                    stop_combobox ctx

                sum = c_check_values[0].uint + c_check_values[1].uint + c_check_values[2].uint + c_check_values[3].uint + c_check_values[4].uint
                if ctx.start_combobox($sum, [200f, 200]):
                    ctx.dynamic_row 1, 30
                    ctx.checkbox(c_weapons_arr[0], c_check_values[0])
                    ctx.checkbox(c_weapons_arr[1], c_check_values[1])
                    ctx.checkbox(c_weapons_arr[2], c_check_values[2])
                    ctx.checkbox(c_weapons_arr[3], c_check_values[3])
                    ctx.checkbox(c_weapons_arr[4], c_check_values[4])
                    stop_combobox ctx

                let str = &"{c_position[0]}, {c_position[1]}, {c_position[2]}"
                if ctx.start_combobox(str, [200f, 200]):
                    ctx.dynamic_row 1, 25
                    ctx.property "#X: ", c_position[0], -1024.0..1024.0
                    ctx.property "#Y: ", c_position[1], -1024.0..1024.0
                    ctx.property "#Z: ", c_position[2], -1024.0..1024.0
                    stop_combobox ctx

                if ctx.start_combobox($c_chart_selection, [200f, 250]):
                    ctx.dynamic_row 1, 150
                    if ctx.start_chart(ckColumn, int32 c_values.len, 0.0..50.0):
                        for val in c_values:
                            let event = uint ctx.push_chart val
                            if (event and uint ceClicked) != 0:
                                c_chart_selection = val
                                close_combobox ctx
                        stop_chart ctx
                    stop_combobox ctx

                if (not time_selected) or (not date_selected):
                    sel_date = now()
                    sel_time = to_time sel_date
                if ctx.start_combobox($sel_date, [200f, 250]):
                    time_selected = true
                    ctx.dynamic_row 1, 25
                    sel_date.second = ctx.property("#S: ", sel_date.second, 0..<60)
                    sel_date.minute = ctx.property("#M: ", sel_date.minute, 0..<60)
                    sel_date.hour   = ctx.property("#H: ", sel_date.hour  , 0..<24)
                    stop_combobox ctx

                # TODO: date picker
                pop_tree ctx

            if ctx.push_tree(tkNode, "Input"):
                ctx.layout_row lfStatic, 2, [120f, 150], 25
                ctx.label "Default: "; edit_event.incl ctx.edit_simple i_text[0]
                ctx.label "Int: "    ; edit_event.incl ctx.edit_simple(i_text[1], filter = FilterDecimal)
                ctx.label "Float: "  ; edit_event.incl ctx.edit_simple(i_text[2], filter = FilterFloat)
                ctx.label "Hex: "    ; edit_event.incl ctx.edit_simple(i_text[4], filter = FilterHex)
                ctx.label "Oct: "    ; edit_event.incl ctx.edit_simple(i_text[5], filter = FilterOct)
                ctx.label "Binary: " ; edit_event.incl ctx.edit_simple(i_text[6], filter = FilterBinary)

                ctx.label "Field: "
                edit_event.incl ctx.edit_field i_field

                ctx.label "Box: "
                ctx.static_row 1, 278, 180
                edit_event.incl ctx.edit_box i_box

                ctx.layout_row lfStatic, 2, [120f, 150], 25
                let active = ctx.edit_field(i_text[7], filter = FilterAscii)
                edit_event.incl active
                if (ctx.button "Submit") or (eefCommited in active):
                    i_text[7].add '\n'
                    i_box.add i_text[7]
                    i_text[7].set_len 0

                pop_tree ctx

            pop_tree ctx

        if ctx.push_tree(tkTab, "Chart"):
            let step = 2*3.141592654f/32

            # Line Chart
            var idx  = -1'i32
            ctx.dynamic_row 1
            ctx.label "cos(x)", taCentred
            ctx.dynamic_row 1, 100
            if ctx.start_chart(ckLine, 32, -1.0..1.0):
                var id = 0f
                for i in 0..<32:
                    let res = ctx.push_chart(cos id)
                    if ceHovering in res:
                        idx = int32 i
                    if ceClicked in res:
                        chart_line_idx = int32 i
                    id += step
                stop_chart ctx

            if idx != -1:
                ctx.tooltip &"Value: {cos(step*float32 idx)}"
            if chart_line_idx != -1:
                ctx.dynamic_row 1, 20
                ctx.label &"Selected Value: {cos(step*float32 chart_line_idx)}"

            # Column Chart
            idx = -1
            ctx.dynamic_row 1
            ctx.label "abs(sin(x))", taCentred
            ctx.dynamic_row 1, 100
            if ctx.start_chart(ckColumn, 32, 0.0..1.0):
                var id = 0f
                for i in 0..<32:
                    let res = ctx.push_chart(abs sin id)
                    if ceHovering in res:
                        idx = int32 i
                    if ceClicked in res:
                        chart_col_idx = int32 i
                    id += step
                stop_chart ctx

            if idx != -1:
                ctx.tooltip &"Value: {abs sin(step*float32 idx)}"
            if chart_col_idx != -1:
                ctx.dynamic_row 1, 20
                ctx.label &"Selected Value: {abs sin(step*float32 chart_col_idx)}"

            # Mixed Chart
            idx = -1
            ctx.dynamic_row 1
            ctx.label "Mixed Chart", taCentred
            ctx.dynamic_row 1, 100
            if ctx.start_chart(ckColumn, 32, 0.0..1.0, [225'u8, 30, 30, 180], [225'u8, 30, 30, 255]):
                ctx.add_slot ckLine, 32, -1.0..1.0, [30'u8, 225, 30, 180], [30'u8, 225, 30, 255]
                ctx.add_slot ckLine, 32, -1.0..1.0, [30'u8, 30, 225, 180], [30'u8, 30, 225, 255]
                var x = 0f
                for i in 0..<32:
                    ctx.push_slot 0, abs sin float32 x
                    ctx.push_slot 1, cos float32 x
                    ctx.push_slot 2, sin float32 x
                    x += step
                stop_chart ctx

            pop_tree ctx

        if ctx.push_tree(tkTab, "Popup"):
            ctx.static_row 1, 250
            var bounds = ctx.widget_bounds
            ctx.label "Right click me for menu"
            if ctx.start_contextual(nk_vec(100.0, 300.0), bounds):
                ctx.dynamic_row 1, 25
                ctx.checkbox "Menu", p_show_menu
                ctx.progress_bar p_prog, 100, true
                ctx.slider p_slider, 0..16
                if ctx.contextual_item("About", align = taCentred):
                    show_about = true
                ctx.selectable(if selections1[0]: "Unselect" else: "Select", selections1[0])
                ctx.selectable(if selections1[1]: "Unselect" else: "Select", selections1[1])
                ctx.selectable(if selections1[2]: "Unselect" else: "Select", selections1[2])
                ctx.selectable(if selections1[3]: "Unselect" else: "Select", selections1[3])
                stop_contextual ctx

            ctx.start_row lfStatic, 2, 30
            ctx.push_row 150
            ctx.label "Right click here: "
            ctx.push_row 80
            bounds = ctx.widget_bounds
            discard ctx.button nk_colour c_colour
            stop_row ctx
            if ctx.start_contextual(nk_vec(350.0, 60.0), bounds):
                ctx.dynamic_row 4, 65
                c_colour[0] = uint8 ctx.property("#r", int32 c_colour[0], 0..255)
                c_colour[1] = uint8 ctx.property("#g", int32 c_colour[1], 0..255)
                c_colour[2] = uint8 ctx.property("#b", int32 c_colour[2], 0..255)
                c_colour[3] = uint8 ctx.property("#a", int32 c_colour[3], 0..255)
                stop_contextual ctx

            ctx.start_row lfStatic, 2, 30
            ctx.push_row 150
            ctx.label "Popup: "
            ctx.push_row 65
            if ctx.button "Popup":
                p_popup_active = true
            if p_popup_active:
                if ctx.start_popup(pkStatic, "Error", nk_rect(20.0, 150.0, 300.0, 110.0)):
                    ctx.dynamic_row 1
                    ctx.label "A terrible error has occured", taCentred
                    ctx.dynamic_row 2, 25
                    if ctx.button "Ok":
                        p_popup_active = false
                        close_popup ctx
                    elif ctx.button "Cancel":
                        p_popup_active = false
                        close_popup ctx
                    stop_popup ctx
                else:
                    p_popup_active = false

            ctx.static_row 1, 150
            bounds = ctx.widget_bounds
            ctx.label "Hover me for tooltip"
            if ctx.is_mouse_hovering bounds:
                ctx.tooltip "This is a tooltip"

            pop_tree ctx

        if ctx.push_tree(tkTab, "Layout"):
            if ctx.push_tree(tkNode, "Widget"):
                const r2 = [0.2f, 0.6, 0.2]
                const w2 = [100f, 200, 50]

                ctx.dynamic_row 1, 30
                ctx.label "Dynamic fixed column layout with generated position and size:"
                ctx.dynamic_row 3, 30
                discard ctx.button "Button"
                discard ctx.button "Button"
                discard ctx.button "Button"

                ctx.dynamic_row 1, 30
                ctx.label "Static fixed column layout with generated position and size:"
                ctx.static_row 3, 300, 30
                discard ctx.button "Button"
                discard ctx.button "Button"
                discard ctx.button "Button"

                ctx.dynamic_row 1, 30
                ctx.label "Dynamic array-based custom column layout with generated position and custom size:"
                ctx.layout_row lfDynamic, 3, r2, 30
                discard ctx.button "Button"
                discard ctx.button "Button"
                discard ctx.button "Button"

                ctx.dynamic_row 1, 30
                ctx.label "Static array-based custom column layout with generated position and custom size:"
                ctx.layout_row lfStatic, 3, w2, 30
                discard ctx.button "Button"
                discard ctx.button "Button"
                discard ctx.button "Button"

                ctx.dynamic_row 1, 30
                ctx.label "Static free space with custom position and custom size:"
                ctx.start_space lfStatic, 4, 60
                ctx.push_space nk_rect(100.0, 0.0, 100.0, 30.0)
                discard ctx.button "Button"
                ctx.push_space nk_rect(0.0, 15.0, 100.0, 30.0)
                discard ctx.button "Button"
                ctx.push_space nk_rect(200.0, 15.0, 100.0, 30.0)
                discard ctx.button "Button"
                ctx.push_space nk_rect(100.0, 30.0, 100.0, 30.0)
                discard ctx.button "Button"
                stop_space ctx

                ctx.dynamic_row 1, 30
                ctx.label "Row template: "
                ctx.start_row_template 30
                ctx.push_template_dynamic
                ctx.push_template_variable 80
                ctx.push_template_static 80
                stop_row_template ctx

                discard ctx.button "Button"
                discard ctx.button "Button"
                discard ctx.button "Button"

                pop_tree ctx

            if ctx.push_tree(tkNode, "Group"):
                var flags: WindowFlag
                if     g_titlebar : flags.incl pfTitle
                if     g_border   : flags.incl pfBorder
                if not g_scrollbar: flags.incl pfNoScrollbar

                ctx.dynamic_row 3, 30
                ctx.checkbox "Titlebar" , g_titlebar
                ctx.checkbox "Border"   , g_border
                ctx.checkbox "Scrollbar", g_scrollbar

                ctx.start_row lfStatic, 3, 22
                ctx.push_row 50
                ctx.label "Size: "
                ctx.push_row 130
                ctx.property "#Width: ", g_w, 100..500, 10, 1
                ctx.push_row 130
                ctx.property "#Height: ", g_h, 100..500, 10, 1
                stop_row ctx

                ctx.static_row 2, float32 g_w, float32 g_h
                if ctx.start_group("Group", flags):
                    ctx.static_row 1, 100
                    for row in mitems g_selected:
                        for cell in mitems row:
                            ctx.selectable (if cell: "Selected" else: "Unselected"), cell
                    stop_group ctx

                pop_tree ctx

            if ctx.push_tree(tkNode, "Notebook"):
                let step    = float32 2*3.141592654/32
                const names = ["Lines", "Columns", "Mixed"]

                let font = ctx.style.font
                ctx.push_style_vec   ctx.style.win.spacing , nk_vec(0.0, 0.0)
                ctx.push_style_float ctx.style.btn.rounding, 0
                ctx.start_row lfStatic, 3, 20
                for i in 0..2:
                    let text_w   = font.w(font.user_data, font.h, cstring names[i], cint names[i].len)
                    let widget_w = text_w + 3*ctx.style.btn.padding.x
                    ctx.push_row widget_w
                    if n_tab.ord == i:
                        let btn_colour = ctx.style.btn.normal
                        ctx.style.btn.normal = ctx.style.btn.active
                        n_tab = if ctx.button names[i]: ChartKind i else: n_tab
                        ctx.style.btn.normal = btn_colour
                    else:
                        n_tab = if ctx.button names[i]: ChartKind i else: n_tab

                pop_style_float ctx
                pop_style_vec ctx

                ctx.dynamic_row 1, 200
                if ctx.start_group("Notebook", wfNone):
                    var idx = -1'i32
                    case n_tab
                    of cLine:
                        ctx.dynamic_row 1
                        ctx.label "cos(x)", taCentred
                        ctx.dynamic_row 1, 100
                        if ctx.start_chart(ckLine, 32, -1.0..1.0):
                            var id = 0f
                            for i in 0..<32:
                                let res = ctx.push_chart(cos id)
                                if ceHovering in res:
                                    idx = int32 i
                                if ceClicked in res:
                                    chart_line_idx = int32 i
                                id += step
                            stop_chart ctx

                        if idx != -1:
                            ctx.tooltip &"Value: {cos(step*float32 idx)}"
                        if chart_line_idx != -1:
                            ctx.dynamic_row 1, 20
                            ctx.label &"Selected Value: {cos(step*float32 chart_line_idx)}"
                    of cHisto:
                        ctx.dynamic_row 1
                        ctx.label "abs(sin(x))", taCentred
                        ctx.dynamic_row 1, 100
                        if ctx.start_chart(ckColumn, 32, 0.0..1.0):
                            var id = 0f
                            for i in 0..<32:
                                let res = ctx.push_chart(abs sin id)
                                if ceHovering in res:
                                    idx = int32 i
                                if ceClicked in res:
                                    chart_col_idx = int32 i
                                id += step
                            stop_chart ctx

                        if idx != -1:
                            ctx.tooltip &"Value: {abs sin(step*float32 idx)}"
                        if chart_col_idx != -1:
                            ctx.dynamic_row 1, 20
                            ctx.label &"Selected Value: {abs sin(step*float32 chart_col_idx)}"
                    of cMixed:
                        ctx.dynamic_row 1
                        ctx.label "Mixed Chart", taCentred
                        ctx.dynamic_row 1, 100
                        if ctx.start_chart(ckColumn, 32, 0.0..1.0, [225'u8, 30, 30, 180], [225'u8, 30, 30, 255]):
                            ctx.add_slot ckLine, 32, -1.0..1.0, [30'u8, 225, 30, 180], [30'u8, 225, 30, 255]
                            ctx.add_slot ckLine, 32, -1.0..1.0, [30'u8, 30, 225, 180], [30'u8, 30, 225, 255]
                            var x = 0f
                            for i in 0..<32:
                                ctx.push_slot 0, abs sin float32 x
                                ctx.push_slot 1, cos float32 x
                                ctx.push_slot 2, sin float32 x
                                x += step
                            stop_chart ctx
                stop_group ctx

                pop_tree ctx

            pop_tree ctx

    stop ctx
    result = (eefActive in edit_event) or (eefActivated in edit_event)
