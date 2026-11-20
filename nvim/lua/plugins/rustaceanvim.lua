-- https://github.com/mrcjkb/rustaceanvim
return {
    'mrcjkb/rustaceanvim',
    version = '^9',
    lazy = false,
    init = function()
        vim.g.rustaceanvim = {
            server = {
                default_settings = {
                    ['rust-analyzer'] = {
                        inlayHints = {
                            closingBraceHints = {
                                enable = false,
                            },
                        },
                    },
                },
            },
        }
    end,
}
