-- https://github.com/ray-x/go.nvim
return {
    'ray-x/go.nvim',
    dependencies = {
        'ray-x/guihua.lua',
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter',
    },
    ft = { 'go', 'gomod' },
    build = function()
        require('go.install').update_all_sync()
    end,
    opts = {
        lsp_cfg = true,
    },
    init = function()
        local format_sync_grp = vim.api.nvim_create_augroup('GoFormat', {})
        vim.api.nvim_create_autocmd('BufWritePre', {
            pattern = '*.go',
            callback = function()
                require('go.format').goimports()
            end,
            group = format_sync_grp,
        })
    end,
}
