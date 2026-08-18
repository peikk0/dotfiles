-- https://github.com/dlyongemallo/diffview-plus.nvim
-- (fork of https://github.com/sindrets/diffview.nvim)
return {
    -- 'sindrets/diffview.nvim'
    'dlyongemallo/diffview-plus.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = {
        'DiffviewOpen',
        'DiffviewToggle',
        'DiffviewFileHistory',
        'DiffviewDiffFiles',
        'DiffviewLog',
    },
}
