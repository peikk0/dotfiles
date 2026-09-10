-- https://github.com/stevearc/conform.nvim

return {
    'stevearc/conform.nvim',
    opts = {
        default_format_opts = {
            lsp_format = 'fallback',
        },
        formatters_by_ft = {
            bash = { 'shfmt' },
            lua = { 'stylua' },
            rust = { 'rustfmt' },
            sh = { 'shfmt' },
            zsh = { 'shfmt' },
        },
        format_on_save = {
            timeout_ms = 500,
        },
    },
}
