local wezterm = require 'wezterm';

return {
    allow_square_glyphs_to_overflow_width = 'WhenFollowedBySpace',
    color_scheme = "nord",
    custom_block_glyphs = false,
    default_cursor_style = "BlinkingUnderline",
    font = wezterm.font_with_fallback {
        'FiraCode Nerd Font',
        'FiraMono Nerd Font',
        'Fira Code',
        'Fira Mono',
        'Menlo',
        'Roboto',
        'Noto Mono',
        'Noto Sans Mono',
        'DejaVu Sans Mono',
        'Liberation Mono',
    },
    font_size = 12.0,
    hide_tab_bar_if_only_one_tab = true,
    window_background_opacity = 0.95
}
