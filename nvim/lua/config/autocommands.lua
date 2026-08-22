-- Autocommands

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
