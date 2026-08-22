-- https://github.com/ibhagwan/fzf-lua
return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    keys = {
        {
            '<C-p>',
            function()
                require('fzf-lua').global()
            end,
            desc = 'Global picker (files, buffers, LSP symbols)',
        },
        {
            '<Leader>ff',
            function()
                require('fzf-lua').files()
            end,
            desc = 'Find file',
        },
        {
            '<Leader>fr',
            function()
                require('fzf-lua').files({ resume = true })
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
            '<Leader>rg',
            function()
                require('fzf-lua').grep()
            end,
            desc = 'Ripgrep search',
        },
        {
            '<Leader>rr',
            function()
                require('fzf-lua').grep({ resume = true })
            end,
            desc = 'Ripgrep search',
        },
        {
            '<Leader>fb',
            function()
                require('fzf-lua').builtin()
            end,
            desc = 'FZF built-in commands',
        },
        {
            '<Leader>ca',
            function()
                require('fzf-lua').lsp_code_actions()
            end,
            desc = 'LSP code actions',
        },
        {
            '<Leader>dd',
            function()
                require('fzf-lua').diagnostics_document()
            end,
            desc = 'Document Diagnostics',
        },
    },
    opts = {},
    config = function(_, opts)
        require('fzf-lua').setup(opts)
        require('fzf-lua').register_ui_select()
    end,
}
