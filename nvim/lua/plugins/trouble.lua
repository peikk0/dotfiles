-- https://github.com/folke/trouble.nvim
return {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {},
    keys = {
        {
            '<Leader>xx',
            '<cmd>Trouble diagnostics toggle<cr>',
            desc = 'Diagnostics (Trouble)',
        },
        {
            '<Leader>xX',
            '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
            desc = 'Buffer Diagnostics (Trouble)',
        },
        {
            '<Leader>cs',
            '<cmd>Trouble symbols toggle focus=false<cr>',
            desc = 'Symbols (Trouble)',
        },
        {
            '<Leader>cl',
            '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
            desc = 'LSP Definitions / references / ... (Trouble)',
        },
        {
            '<Leader>xL',
            '<cmd>Trouble loclist toggle<cr>',
            desc = 'Location List (Trouble)',
        },
        {
            '<Leader>xQ',
            '<cmd>Trouble qflist toggle<cr>',
            desc = 'Quickfix List (Trouble)',
        },
    },
}
