-- {{{ force use of a POSIX shell

vim.opt.shell = '/bin/sh'

-- }}}

-- {{{ Colors

vim.opt.termguicolors = true

-- }}}

--- {{{ lazy.nvim - https://lazy.folke.io/

require('config.lazy')

-- }}}

-- {{{ Enable syntax

vim.cmd.filetype('plugin indent on')
vim.cmd.syntax('on')

-- }}}

-- {{{ Various settings

vim.opt.modeline = true
vim.opt.modelines = 3

vim.opt.backup = false
vim.opt.swapfile = true
vim.opt.undofile = false

vim.opt.autoread = true
vim.opt.tabpagemax = 50
vim.opt.updatetime = 100

vim.opt.title = true
vim.opt.shortmess = 'aoOtTI'
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.joinspaces = false
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.smarttab = true

vim.opt.showbreak = ' '
vim.opt.list = true
vim.opt.listchars = {
    tab = '⇥‐',
    trail = '•',
    extends = '⇉',
    precedes = '⇇',
    nbsp = '␣',
}
vim.opt.fillchars = {
    vert = '▚',
    fold = '·',
}

vim.opt.selection = 'inclusive'
vim.opt.virtualedit = 'block'

vim.opt.conceallevel = 2
vim.opt.cursorline = true
vim.opt.guicursor = '' -- disable cursor shape changes
vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.showcmd = true

vim.opt.pumborder = 'rounded'
vim.opt.winborder = 'rounded'

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 3
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 5
vim.opt.scrolljump = 1
vim.opt.display = { 'lastline', 'uhex' }

vim.opt.completeopt = { 'longest', 'menu' }

vim.opt.diffopt:append('vertical')

vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 250

vim.opt.mouse = '' -- disable mouse support

-- }}}

-- {{{ Autocommands

local norelnumins = vim.api.nvim_create_augroup('no_relative_number_in_insert_mode', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
  pattern = '*',
  group = norelnumins,
  command = 'set norelativenumber',
})
vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  pattern = '*',
  group = norelnumins,
  command = 'set relativenumber',
})

local filetype_settings = vim.api.nvim_create_augroup('filetype_settings', { clear = false })
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'go',
  group = filetype_settings,
  command = 'setlocal shiftwidth=8 tabstop=8 noexpandtab',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'helm',
  group = filetype_settings,
  command = 'setlocal shiftwidth=2 tabstop=2',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'json',
  group = filetype_settings,
  command = 'setlocal foldmethod=syntax',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'jsonnet',
  group = filetype_settings,
  command = 'setlocal shiftwidth=2 tabstop=2',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'python',
  group = filetype_settings,
  command = 'setlocal shiftwidth=4 tabstop=4',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'ruby',
  group = filetype_settings,
  command = 'setlocal shiftwidth=2 tabstop=2',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'text',
  group = filetype_settings,
  command = 'setlocal textwidth=120',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'yaml',
  group = filetype_settings,
  command = 'setlocal shiftwidth=2 tabstop=2',
})

-- }}}
