-- https://github.com/akinsho/bufferline.nvim
return {
    'akinsho/bufferline.nvim',
    dependencies = {
        'catppuccin/nvim',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        always_show_bufferline = true,
        diagnostics = 'nvim_lsp',
        indicator = {
            icon = '▎',
            style = 'icon',
        },
        mode = 'tabs',
        numbers = 'ordinal',
        -- separator_style = { '', '' },
        separator_style = 'thin',
        show_close_icon = false,
        show_tab_indicator = true,
        themable = true,
    },
    config = function(_, opts)
        require('bufferline').setup({
            highlights = require('catppuccin.special.bufferline').get_theme(),
            options = opts,
        })
    end,
}
