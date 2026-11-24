-- Autocommands

local norelnumins = vim.api.nvim_create_augroup('no_relative_number_in_insert_mode', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
    pattern = '*',
    group = norelnumins,
    command = 'set norelativenumber',
})
vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
    pattern = '*',
    group = norelnumins,
    command = 'set relativenumber',
})

local filetype_settings = vim.api.nvim_create_augroup('filetype_settings', { clear = false })
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'go',
    group = filetype_settings,
    command = 'setlocal shiftwidth=8 tabstop=8 noexpandtab',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'helm',
    group = filetype_settings,
    command = 'setlocal shiftwidth=2 tabstop=2',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'json',
    group = filetype_settings,
    command = 'setlocal foldmethod=syntax',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'jsonnet',
    group = filetype_settings,
    command = 'setlocal shiftwidth=2 tabstop=2',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'python',
    group = filetype_settings,
    command = 'setlocal shiftwidth=4 tabstop=4',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'ruby',
    group = filetype_settings,
    command = 'setlocal shiftwidth=2 tabstop=2',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'text',
    group = filetype_settings,
    command = 'setlocal textwidth=120',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'yaml',
    group = filetype_settings,
    command = 'setlocal shiftwidth=2 tabstop=2',
})

local lsp = vim.api.nvim_create_augroup('lsp', { clear = false })
vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    group = lsp,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, silent = true, desc = desc })
        end
        if client and client.name == 'gopls' then
            map({ 'n', 'x' }, '<Leader>a', function()
                require('go.codeaction').run_code_action()
            end, 'Go code action')
        elseif client and client.name == 'rust-analyzer' then
            map({ 'n', 'x' }, '<Leader>a', function()
                vim.cmd.RustLsp('codeAction')
            end, 'Rust code action')
            map('n', 'K', function()
                vim.cmd.RustLsp({ 'hover', 'actions' })
            end, 'Rust hover actions')
        else
            map({ 'n', 'x' }, '<Leader>a', vim.lsp.buf.code_action, 'LSP code action')
        end
        map('n', 'gd', vim.lsp.buf.definition, 'LSP definition')
        map('n', 'gD', vim.lsp.buf.type_definition, 'LSP type definition')
        map('n', 'gi', vim.lsp.buf.implementation, 'LSP implementation')

        -- Enable inlay hints by default, disable in insert mode
        if client and client:supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })

            local inlay_hints_group = vim.api.nvim_create_augroup('toggle_inlay_hints', { clear = false })

            vim.api.nvim_create_autocmd('InsertEnter', {
                group = inlay_hints_group,
                desc = 'Disable inlay hints',
                buffer = args.buf,
                callback = function()
                    vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
                end,
            })

            vim.api.nvim_create_autocmd('InsertLeave', {
                group = inlay_hints_group,
                desc = 'Enable inlay hints',
                buffer = args.buf,
                callback = function()
                    vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                end,
            })
        end
    end,
})
