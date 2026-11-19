-- https://github.com/nvim-lualine/lualine.nvim
return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'catppuccin-nvim',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = {
                { 'branch', icon = ' ' },
                { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } },
                { 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
            },
            lualine_c = {
                { 'filename', path = 1 },
            },
            lualine_x = {
                {
                    'lsp_status',
                    icon = '',
                    symbols = { done = '', spinner = { '', '', '', '', '', '' } },
                },
                { 'encoding', show_bomb = true },
                { 'fileformat', symbols = { unix = '', dos = '', mac = '' } },
                { 'filetype' },
            },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
    },
}
