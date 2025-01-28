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
    c_values          = [26f, 13, 30, 15, 25, 10, 20, 40, 12, 8, 22, 28, 5]

    time_selected = false
    date_selected = false
    sel_time: Time
    sel_date: DateTime

    i_text : array[9, string]
    i_field: string
    i_box  : string

    chart_col_idx  = -1'i32
    chart_line_idx = -1'i32

    p_prog   = 40u
    p_slider = 10'i32
    p_show_menu   : bool
    p_popup_active: bool

    g_w = 320'i32
    g_h = 320'i32
    g_titlebar : bool
    g_border   : bool
    g_scrollbar: bool
    g_selected : array[4, array[4, bool]]

    n_tab: ChartKind



    menu_state: CollapseState

proc full_ui_example*(ctx: var Context): bool =
    hide_cursor ctx
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

        ctx.StaticPopup show_about, "About", [20, 100, 300, 200]:
            Label "Nuklear"
            Label "By Micha Mettke"
            StaticRow 1, 250, 75
            LabelWrap "Nuklear is licensed under the public domain license."

        if show_menu:
            ctx.MenuBar 5, [0.1f, 0.15, 0.2, 0.2, 0.1]:
                # Menu 1
                StartMenu "Menu", (120, 200):
                    "Hide" : show_menu  = false
                    "About": show_about = true

                    Progress menu1_prog, 100, true
                    Slider   menu1_slider, 0..16
                    Checkbox menu1_check, "Check"

                # Menu 2
                StartMenu "Advanced", (200, 600):
                    TabTree "File":
                        MenuItem "New"  : echo "New"
                        MenuItem "Open" : echo "Open"
                        MenuItem "Save" : echo "Save"
                        MenuItem "Close": echo "Close"
                        MenuItem "Exit" : echo "Exit"

                    TabTree "Edit":
                        MenuItem "Copy"  : echo "Copy"
                        MenuItem "Delete": echo "Delete"
                        MenuItem "Cut"   : echo "Cut"
                        MenuItem "Paste" : echo "Paste"

                    TabTree "View":
                        MenuItem "About"    : echo "About"
                        MenuItem "Options"  : echo "Options"
                        MenuItem "Customize": echo "Customize"

                    const Data = [26, 13, 30, 15, 25, 10, 20, 40, 12, 8, 22, 28]
                    TabTree "Chart":
                        ColumnChart Data, 0.0..50.0, 150

                Progress menu_prog  , 100, true
                Slider   menu_slider, 0..16
                Checkbox menu_check , "Check"

    stop ctx
    result = (eefActive in edit_event) or (eefActivated in edit_event)
