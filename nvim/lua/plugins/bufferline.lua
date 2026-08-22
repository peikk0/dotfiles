-- https://github.com/akinsho/bufferline.nvim
return {
    'akinsho/bufferline.nvim',
    dependencies = {
        'gbprod/nord.nvim',
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
            highlights = require('nord.plugins.bufferline').akinsho(),
            options = opts,
        })
    end,
}
