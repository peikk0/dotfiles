local wezterm = require 'wezterm';

-- calt -> texture healing
-- case -> :0 :A ¡0 ¡A (vertical alignment for : and ¡)
-- cv01 -> 0 alternates (1: plain, 2: slash, 3: reverse slash, 4: cut-out slash)
-- cv02 -> 1 alternate (no serif)
-- cv10 -> l i alternates (Neon, Argon, Xenon, Radon))
-- cv11 -> j f r t alternates (Neon, Argon)
-- cv30 -> * vertically aligned closer to the top of the space
-- cv31 -> * 6-pointed asterisk
-- cv32 -> >= <= angled lower line
-- cv60 -> forces the <= pair to render in a fashion that matches => instead of swapping for ≤
-- cv61 -> enables the optional closed square ligature for []
-- cv62 -> @_
-- liga -> ... /// // !! || ;; ;;;
-- ss01 -> === !== =!= =/= /== /= #= == != ~~ =~ !~ ~- -~ &=
-- ss02 -> >= <=
-- ss03 -> <--> <-> <!-- <-- --> <- -> <~> <~~ ~~> <~ ~>
-- ss04 -> </ /> </> <>
-- ss05 -> [| |] /\ \/ |> <| <|> {| |}
-- ss06 -> ### +++ &&&
-- ss07 -> -:- =:= :>: :<: ::> <:: :: :::
-- ss08 -> ..= ..- ..< .= .-
-- ss09 -> <=> <<= =>> =<< >>= => << >>
-- ss10 -> #[ #(
local monaspace_ligatures = { 'calt', 'cv01=2', 'cv02', 'cv32', 'liga', 'ss01', 'ss02', 'ss03', 'ss04', 'ss06', 'ss07', 'ss08', 'ss09', 'ss10' };

return {
    adjust_window_size_when_changing_font_size = false,
    allow_square_glyphs_to_overflow_width = 'WhenFollowedBySpace',
    audible_bell = 'Disabled',
    check_for_updates = false,
    color_scheme = 'nord',
    colors = {
        tab_bar = {
            inactive_tab_edge = '#4C566A',
            active_tab = {
                bg_color = '#81A1C1',
                fg_color = '#3B4252',
            },
            inactive_tab = {
                bg_color = '#3B4252',
                fg_color = '#81A1C1',
            },
            inactive_tab_hover = {
                bg_color = '#4C566A',
                fg_color = '#88C0D0',
            },
            new_tab = {
                bg_color = '#3B4252',
                fg_color = '#81A1C1',
            },
            new_tab_hover = {
                bg_color = '#4C566A',
                fg_color = '#88C0D0',
            },
        },
    },
    custom_block_glyphs = true,
    default_cursor_style = 'BlinkingUnderline',
    font = wezterm.font_with_fallback {
        { family = 'MonaspiceAr NF', weight = 'Regular', harfbuzz_features = monaspace_ligatures },
        'FiraCode Nerd Font',
        'FiraMono Nerd Font',
        'NotoMono Nerd Font',
        'Monaspace Argon',
        'Fira Code',
        'Fira Mono',
        'Noto Mono',
        'Menlo',
        'Monaco',
        'Roboto',
        'DejaVu Sans Mono',
        'Liberation Mono',
    },
    font_rules = {
        {
            intensity = 'Bold',
            font = wezterm.font_with_fallback {
                { family = 'MonaspiceAr NF', weight = 'Medium', harfbuzz_features = monaspace_ligatures }
            },
        },
        {
            italic = true,
            font = wezterm.font_with_fallback {
                { italic = true, family = 'MonaspiceRn NF', weight = 'Regular', harfbuzz_features = monaspace_ligatures }
            },
        },
    },
    font_size = 13.0,
    hide_tab_bar_if_only_one_tab = true,
    keys = {
        {
            key = 'Enter',
            mods = 'ALT',
            action = wezterm.action.DisableDefaultAssignment,
        },
    },
    mouse_bindings = {
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'NONE',
            action = wezterm.action.CompleteSelection 'PrimarySelection',
        },
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'SUPER',
            action = wezterm.action.OpenLinkAtMouseCursor,
        },
    },
    show_new_tab_button_in_tab_bar = false,
    window_background_opacity = 0.85,
    macos_window_background_blur = 25,
    window_decorations = 'RESIZE',
    window_frame = {
        font = wezterm.font { family = 'MonaspiceAr NF', italic = true, weight = 'Medium', harfbuzz_features = monaspace_ligatures },
        font_size = 11.0,

        active_titlebar_bg = '#2E3440',
        active_titlebar_fg = '#ECEFF4',
        inactive_titlebar_bg = '#2E3440',
        inactive_titlebar_fg = '#D8DEE9',

        border_left_width = '2px',
        border_right_width = '2px',
        border_bottom_height = '2px',
        border_top_height = '2px',
        border_left_color = '#3B4252',
        border_right_color = '#3B4252',
        border_bottom_color = '#3B4252',
        border_top_color = '#3B4252',
    },
}
