-- https://github.com/Wansmer/treesj
return {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
        use_default_keymaps = false
    },
    keys = {
        {
            '<Leader>j',
            function()
                require('treesj').join()
            end,
            desc = 'Join lines'
        },
        {
            '<Leader>s',
            function()
                require('treesj').split()
            end,
            desc = 'Split lines'
        },
    },
}
