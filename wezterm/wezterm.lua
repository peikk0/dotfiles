local wezterm = require('wezterm')
local mux = wezterm.mux

local monaspace_ligatures = {
    'calt',   -- texture healing
    'case',   -- :0 :A ¡0 ¡A (vertical alignment for : and ¡)
    'cv01=2', -- 0 alternates (1: plain, 2: slash, 3: reverse slash, 4: cut-out slash)
    'cv02',   -- 1 alternate (no serif)
    -- 'cv10', -- l i alternates (Neon, Argon, Xenon, Radon))
    -- 'cv11', -- j f r t alternates (Neon, Argon)
    -- 'cv30', -- * vertically aligned closer to the top of the space
    -- 'cv31', -- * 6-pointed asterisk
    'cv32', -- >= <= angled lower line
    -- 'cv60', -- forces the <= pair to render in a fashion that matches => instead of swapping for ≤
    -- 'cv61', -- enables the optional closed square ligature for []
    -- 'cv62', -- @_
    'liga', -- ... /// // !! || ;; ;;;
    'ss01', -- === !== =!= =/= /== /= #= == != ~~ =~ !~ ~- -~ &=
    'ss02', -- >= <=
    'ss03', -- <--> <-> <!-- <-- --> <- -> <~> <~~ ~~> <~ ~>
    'ss04', -- </ /> </> <>
    -- 'ss05', -- [| |] /\ \/ |> <| <|> {| |}
    'ss06', -- ### +++ &&& ___ ‗‗‗ ====
    'ss07', -- -:- =:= :>: :<: ::> <:: :: :::
    'ss08', -- ..= ..- ..< .= .-
    'ss09', -- <=> <<= =>> =<< >>= => << >>
    'ss10', -- #[ #(
}

wezterm.on('gui-startup', function(cmd)
    local _, _, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

return {
    adjust_window_size_when_changing_font_size = false,
    allow_square_glyphs_to_overflow_width = 'WhenFollowedBySpace',
    audible_bell = 'Disabled',
    check_for_updates = false,
    color_scheme = 'Catppuccin Mocha',
    custom_block_glyphs = true,
    default_cursor_style = 'BlinkingUnderline',
    enable_kitty_keyboard = false,
    enable_wayland = true,
    font = wezterm.font_with_fallback({
        { family = 'MonaspiceAr NF', weight = 'Regular', harfbuzz_features = monaspace_ligatures },
        'FiraCode Nerd Font',
        'FiraMono Nerd Font',
        'NotoMono Nerd Font',
        'Apple Color Emoji',
        'Noto Color Emoji',
        'Monaspace Argon',
        'Fira Code',
        'Fira Mono',
        'Noto Mono',
        'Menlo',
        'Monaco',
        'Roboto',
        'DejaVu Sans Mono',
        'Liberation Mono',
    }),
    font_rules = {
        {
            intensity = 'Bold',
            font = wezterm.font_with_fallback({
                { family = 'MonaspiceAr NF', weight = 'Bold', harfbuzz_features = monaspace_ligatures },
            }),
        },
        {
            italic = true,
            font = wezterm.font_with_fallback({
                {
                    italic = true,
                    family = 'MonaspiceRn NF',
                    weight = 'Regular',
                    harfbuzz_features = monaspace_ligatures,
                },
            }),
        },
    },
    font_size = 11.0,
    hide_tab_bar_if_only_one_tab = true,
    hyperlink_rules = (function()
        local rules = wezterm.default_hyperlink_rules()
        -- Match Markdown-style links: [text](URL) — capture URL without trailing `)`.
        table.insert(rules, 1, {
            regex = [=[\[[^]]*\]\((\w+://[^)\s]+)\)]=],
            format = '$1',
            highlight = 1,
        })
        -- Replace the default bare-URL rule so a trailing `)` is only kept
        -- when the URL itself contains a matching `(`. Prevents Markdown
        -- `(https://example.com/foo)` from including the closing paren.
        for i, rule in ipairs(rules) do
            if rule.regex == [=[\b\w+://\S+[)/a-zA-Z0-9-]+]=] then
                rules[i] = {
                    regex =
                    [=[\b\w+://[^\s()<>\[\]{}]+(?:\([^\s()<>\[\]{}]*\)[^\s()<>\[\]{}]*)*[/a-zA-Z0-9_%$+~#?&=@-]]=],
                    format = '$0',
                }
                break
            end
        end
        return rules
    end)(),
    keys = {
        {
            key = 'Enter',
            mods = 'ALT',
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = 'f',
            mods = 'CTRL|CMD',
            action = wezterm.action.ToggleFullScreen
        },
    },
    mouse_bindings = {
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'NONE',
            action = wezterm.action.CompleteSelection('PrimarySelection'),
        },
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'SUPER',
            action = wezterm.action.OpenLinkAtMouseCursor,
        },
    },
    macos_window_background_blur = 25,
    show_new_tab_button_in_tab_bar = false,
    term = 'wezterm',
    window_background_opacity = 0.85,
    window_decorations = 'RESIZE',
    window_frame = {
        font = wezterm.font({
            family = 'MonaspiceAr NF',
            italic = true,
            weight = 'Medium',
            harfbuzz_features = monaspace_ligatures,
        }),
        font_size = 11.0,

        active_titlebar_bg = '#1E1E2E',
        active_titlebar_fg = '#89B4FA',
        inactive_titlebar_bg = '#1E1E2E',
        inactive_titlebar_fg = '#6C7086',

        border_left_width = '2px',
        border_right_width = '2px',
        border_bottom_height = '2px',
        border_top_height = '2px',
        border_left_color = '#1E1E2E',
        border_right_color = '#1E1E2E',
        border_bottom_color = '#1E1E2E',
        border_top_color = '#1E1E2E',
    },
}
