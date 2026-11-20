-- https://github.com/Saecki/crates.nvim
return {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {
        lsp = {
            enabled = true,
            actions = true,
            completion = true,
            hover = true,
        },
    },
}
