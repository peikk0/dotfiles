-- User commands

vim.api.nvim_create_user_command('InlayHintsToggle', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, {})

vim.api.nvim_create_user_command('InlayHintsEnable', function()
    vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
end, {})

vim.api.nvim_create_user_command('InlayHintsDisable', function()
    vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
end, {})
