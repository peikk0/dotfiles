-- https://github.com/2KAbhishek/nerdy.nvim

return {
    '2kabhishek/nerdy.nvim',
    opts = {},
    cmd = 'Nerdy',
    keys = {
        { '<leader>in', '<cmd>Nerdy list<CR>', desc = 'Browse nerd icons' },
        { '<leader>iN', '<cmd>Nerdy recents<CR>', desc = 'Browse recent nerd icons' },
    },
}
