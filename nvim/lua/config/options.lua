-- Options

-- Force use of a POSIX shell
vim.opt.shell = '/bin/sh'

vim.opt.termguicolors = true

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
