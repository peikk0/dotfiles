-- https://github.com/saghen/blink.cmp
return {
    'saghen/blink.cmp',
    dependencies = {
        'saghen/blink.lib',
        'rafamadriz/friendly-snippets',
    },
    build = function()
        require('blink.cmp').build():pwait()
    end,
    opts = {
        keymap = { preset= 'super-tab' },
        signature = { enabled = true },
    },
}
