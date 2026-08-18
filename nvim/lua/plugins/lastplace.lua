-- https://github.com/farmergreg/vim-lastplace
return {
    'farmergreg/vim-lastplace',
    config = function()
        vim.g.lastplace_ignore = 'gitcommit,gitrebase,hgcommit,svn,xxd'
        vim.g.lastplace_ignore_buftype = 'help,nofile,quickfix'
        vim.g.lastplace_open_folds = 1
    end,
}
