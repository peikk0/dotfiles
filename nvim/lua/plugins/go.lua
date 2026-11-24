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
        require('go.install').update_all()
    end,
    opts = {
        lsp_cfg = true,
        gopls_cmd = { 'gopls' },
        lsp_keymaps = false,
    },
}
