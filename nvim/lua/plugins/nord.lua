-- https://github.com/gbprod/nord.nvim
return {
    'gbprod/nord.nvim',
    lazy = false,
    priority = 1000,
    opts ={
        transparent = true,
    },
    init = function()
        vim.cmd.colorscheme('nord')
    end
}
