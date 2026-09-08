-- Keymap

-- Toggle diagnostic virtual lines
vim.keymap.set('n', '<Leader>d', function()
    if vim.diagnostic.config().virtual_lines then
        vim.diagnostic.config({ virtual_lines = false })
    else
        vim.diagnostic.config({ virtual_lines = { current_line = true } })
    end
end, {})
