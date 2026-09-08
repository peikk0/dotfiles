-- https://github.com/saghen/blink.cmp
return {
    'saghen/blink.cmp',
    dependencies = {
        'folke/lazydev.nvim',
        'rafamadriz/friendly-snippets',
        'saghen/blink.lib',
    },
    build = function()
        require('blink.cmp').build():pwait()
    end,
    opts = {
        keymap = { preset = 'super-tab' },
        signature = { enabled = true },
        sources = {
            default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
                lazydev = {
                    name = 'LazyDev',
                    module = 'lazydev.integrations.blink',
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
            },
        },
    },
}
