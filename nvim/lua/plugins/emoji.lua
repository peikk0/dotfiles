-- https://github.com/Allaman/emoji.nvim

return {
    'allaman/emoji.nvim',
    dependencies = {
        'ibhagwan/fzf-lua',
    },
    opts = {},
    ft = { 'markdown', 'text' },
    cmd = 'Emoji',
    keys = {
        {
            '<Leader>ee',
            function()
                require('emoji').insert()
            end,
            desc = 'Insert emoji',
        },
        {
            '<Leader>ek',
            function()
                require('emoji').insert_kaomoji()
            end,
            desc = 'Insert kaomoji',
        },
    },
}
