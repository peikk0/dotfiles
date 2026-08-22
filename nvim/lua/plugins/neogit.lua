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
        {
            '<Leader>gg',
            function()
                vim.cmd.Neogit()
            end,
            desc = 'Show Neogit UI'
        },
    },
    opts = {
        graph_style = 'unicode',
    },
}
