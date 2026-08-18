-- https://github.com/NeogitOrg/neogit
return {
    'NeogitOrg/neogit',
    dependencies = {
        'sindrets/diffview.nvim',
        'ibhagwan/fzf-lua',
    },
    lazy = true,
    cmd = 'Neogit',
    keys = {
        { '<Leader>gg', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' },
    },
    opts = {
        graph_style = 'unicode',
    },
}
