-- https://github.com/Wansmer/treesj
return {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
        use_default_keymaps = false
    },
    init = function()
        vim.keymap.set('n', '<Leader>j', require('treesj').join)
        vim.keymap.set('n', '<Leader>s', require('treesj').split)
    end
}
