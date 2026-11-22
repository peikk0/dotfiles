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
        on_attach = function(bufnr)
            local crates = require('crates')
            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = 'Crates: ' .. desc })
            end

            map('n', '<leader>ct', crates.toggle, 'toggle')
            map('n', '<leader>cr', crates.reload, 'reload')

            map('n', '<leader>cv', crates.show_versions_popup, 'versions popup')
            map('n', '<leader>cf', crates.show_features_popup, 'features popup')
            map('n', '<leader>cd', crates.show_dependencies_popup, 'dependencies popup')

            map('n', '<leader>cu', crates.update_crate, 'update crate')
            map('v', '<leader>cu', crates.update_crates, 'update crates')
            map('n', '<leader>ca', crates.update_all_crates, 'update all')
            map('n', '<leader>cU', crates.upgrade_crate, 'upgrade crate')
            map('v', '<leader>cU', crates.upgrade_crates, 'upgrade crates')
            map('n', '<leader>cA', crates.upgrade_all_crates, 'upgrade all')

            map('n', '<leader>cx', crates.expand_plain_crate_to_inline_table, 'expand to inline table')
            map('n', '<leader>cX', crates.extract_crate_into_table, 'extract into table')

            map('n', '<leader>cH', crates.open_homepage, 'open homepage')
            map('n', '<leader>cR', crates.open_repository, 'open repository')
            map('n', '<leader>cD', crates.open_documentation, 'open documentation')
            map('n', '<leader>cC', crates.open_crates_io, 'open crates.io')
            map('n', '<leader>cL', crates.open_lib_rs, 'open lib.rs')
        end,
    },
}
