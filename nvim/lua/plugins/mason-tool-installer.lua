-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
return {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
        ensure_installed = {
            'codelldb',
            'prettier',
            'shellcheck',
            'shfmt',
            'stylua',
            'yamlfmt',
        },
    },
}
