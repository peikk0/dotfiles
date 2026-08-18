-- https://github.com/nvim-treesitter/nvim-treesitter
return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        default_parsers = {
            -- Bundled parsers
            'c',
            'lua',
            'markdown',
            'markdown_inline',
            'query',
            'vim',
            'vimdoc',
            -- Extra parsers
            'bash',
            'comment',
            'diff',
            'dockerfile',
            'fish',
            'gitcommit',
            'go',
            'gomod',
            'gosum',
            'gotmpl',
            'gowork',
            'hcl',
            'helm',
            'html',
            'javascript',
            'jq',
            'json',
            'lua',
            'python',
            'ruby',
            'rust',
            'sql',
            'terraform',
            'toml',
            'xml',
            'yaml',
            'zsh',
        }
        require('nvim-treesitter').install(default_parsers):wait(300000)
    end,
    init = function()
        vim.treesitter.language.register('bash', 'sh')

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('tree-sitter-enable', { clear = true }),
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match)
                if not lang or not vim.treesitter.language.add(lang) then return end

                -- enable highlights if available
                if vim.treesitter.query.get(lang, 'highlights') then vim.treesitter.start(args.buf) end

                -- enable indents if available
                if vim.treesitter.query.get(lang, 'indents') then
                    vim.opt_local.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
                end

                -- enable folds if available
                -- if vim.treesitter.query.get(lang, 'folds') then
                --     vim.opt_local.foldmethod = 'expr'
                --     vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                -- end
            end
        })
    end
}
