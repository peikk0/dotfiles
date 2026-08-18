-- https://github.com/ibhagwan/fzf-lua
return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    keys = {
        {
            '<C-p>',
            function()
                require('fzf-lua').files()
            end,
            desc = 'Find file',
        },
        {
            '<Leader>gc',
            function()
                require('fzf-lua').git_commits()
            end,
            desc = 'Git commits',
        },
        {
            '<Leader>gd',
            function()
                require('fzf-lua').git_diff()
            end,
            desc = 'Git diff',
        },
        {
            '<Leader>gs',
            function()
                require('fzf-lua').git_status()
            end,
            desc = 'Git status',
        },
        {
            '<Leader>r',
            function()
                require('fzf-lua').grep()
            end,
            desc = 'Ripgrep search',
        },
    },
    opts = {},
}
