-- https://github.com/rachartier/tiny-inline-diagnostic.nvim

return {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    opts = {
        preset = 'ghost',
        options = {
            add_messages = {
                display_count = true,
            },
            multilines = {
                enabled = true,
            },
            show_all_diags_on_cursorline = true,
            show_source = {
                enabled = true,
            },
        },
    },
    config = function(_, opts)
        require('tiny-inline-diagnostic').setup(opts)
        vim.diagnostic.config({ virtual_text = false })
    end,
}
