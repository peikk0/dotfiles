-- https://github.com/stevearc/conform.nvim

return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<Leader>tf',
            function()
                local bufnr = vim.api.nvim_get_current_buf()
                vim.b[bufnr].disable_autoformat = not vim.b[bufnr].disable_autoformat
                vim.notify('Autoformat ' .. (vim.b[bufnr].disable_autoformat and 'disabled' or 'enabled') .. ' (buffer)')
            end,
            desc = 'Toggle autoformat (buffer)',
        },
    },
    opts = {
        default_format_opts = {
            lsp_format = 'fallback',
        },
        formatters_by_ft = {
            bash = { 'shfmt' },
            json = { 'prettier' },
            jsonc = { 'prettier' },
            lua = { 'stylua' },
            python = { 'ruff_fix', 'ruff_format' },
            rust = { 'rustfmt' },
            sh = { 'shfmt' },
            yaml = { 'yamlfmt' },
            zsh = { 'shfmt' },
        },
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500 }
        end,
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

        vim.api.nvim_create_user_command('FormatDisable', function(args)
            if args.bang then
                -- FormatDisable! disables formatting for this buffer only
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = 'Disable autoformat-on-save',
            bang = true,
        })
        vim.api.nvim_create_user_command('FormatEnable', function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = 'Re-enable autoformat-on-save',
        })
    end,
}
