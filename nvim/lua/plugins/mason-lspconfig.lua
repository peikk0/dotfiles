-- https://github.com/mason-org/mason-lspconfig.nvim
return {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
        'mason-org/mason.nvim',
        'neovim/nvim-lspconfig',
    },
    opts = {
        ensure_installed = {
            'jsonls',
            'lua_ls',
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
