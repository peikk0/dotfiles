-- https://github.com/junegunn/vim-easy-align
return {
    'junegunn/vim-easy-align',
    init = function()
        vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)')
        vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)')
    end,
}
