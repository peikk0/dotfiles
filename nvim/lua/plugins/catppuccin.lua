-- https://github.com/catppuccin/nvim
return {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
        flavour = 'mocha',
        transparent_background = true,
    },
    init = function()
        vim.cmd.colorscheme('catppuccin-nvim')
    end,
}
