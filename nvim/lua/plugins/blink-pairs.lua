-- https://github.com/saghen/blink.pairs
return {
    'saghen/blink.pairs',
    dependencies = {
        'saghen/blink.lib',
    },
    build = function()
        require('blink.pairs').build():pwait()
    end,
    opts = {},
}
