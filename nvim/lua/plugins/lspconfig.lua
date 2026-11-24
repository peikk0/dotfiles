-- https://github.com/neovim/nvim-lspconfig
return {
    'neovim/nvim-lspconfig',
    init = function()
        -- helm-ls
        vim.lsp.config('helm_ls', {
            settings = {
                ['helm-ls'] = {
                    yamlls = {
                        path = 'yaml-language-server',
                    },
                },
            },
        })
        vim.lsp.enable('helm_ls')
        vim.lsp.enable('yamlls')
    end,
}
