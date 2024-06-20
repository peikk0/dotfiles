local wezterm = require 'wezterm';

-- calt -> texture healing
-- liga -> ... /// // !! || ;;
-- ss01 -> === !== =!= =/= /== /= #= == != ~~ =~ !~
-- ss02 -> >= <=
-- ss03 -> <--> <-> <!-- <-- --> <- -> <~> <~~ ~~> <~ ~>
-- ss04 -> </ /> </> <>
-- ss05 -> [| |] /\ \/ |> <|
-- ss06 -> ### +++ &&&
-- ss07 -> -:- =:= :>: :<: ::> <:: :: :::
-- ss08 -> ..= ..- ..< .= .-
-- ss09 -> <=> <<= =>> =<< >>= => << >>
local monaspace_ligatures = { 'calt', 'liga', 'ss01', 'ss02', 'ss03', 'ss06', 'ss07', 'ss08', 'ss09' };

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
    custom_block_glyphs = false,
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
        font = wezterm.font { family = 'Noto Sans', italic = true, weight = 'Bold' },
        font_size = 12.0,

        active_titlebar_bg = '#2E3440',
        active_titlebar_fg = '#ECEFF4',
        inactive_titlebar_bg = '#2E3440',
        inactive_titlebar_fg = '#D8DEE9',
    },
}
