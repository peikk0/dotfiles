-- https://github.com/mason-org/mason-lspconfig.nvim
return {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
        'mason-org/mason.nvim',
        'neovim/nvim-lspconfig',
    },
    opts = {
        ensure_installed = {
            'bashls',
            'jsonls',
            'lua_ls',
            'tombi',
            'vimls',
            'yamlls',
        },
        automatic_enable = {
            exclude = {
                -- rustaceanvim handles this one
                'rust_analyzer',
            },
        },
    },
}
