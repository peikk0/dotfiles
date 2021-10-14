" peikk0's vimrc

filetype plugin indent on
syntax on

if has('terminfo') || has('nvim')
  if has('packages')
    packadd nord
  endif
  set background=dark
  " https://github.com/tmux/tmux/issues/1246
  if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
  colorscheme nord
end

set modeline
set modelines=3

set backspace=indent,eol,start

set nobackup
set noundofile
set swapfile
set autoread
set updatetime=100
set tabpagemax=50

set title
set shortmess=aoOtTI
set wildmenu
set wildmode=longest:full,full

set viminfo='20,\"500,h
set history=1000

set sessionoptions-=blank
set sessionoptions-=options
set viewoptions-=options

set encoding=utf-8
set fileencodings=utf-8,latin1,default
set fileformats=unix,dos,mac
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent
set omnifunc=syntaxcomplete#Complete

set nrformats-=octal

set formatoptions+=j

let showbreak='> '
set list
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && v:version >= 700
  let &listchars="tab:\u21e5\u2010,trail:\u2022,extends:\u21c9,precedes:\u21c7,nbsp:\u2423"
  let &fillchars="vert:\u259a,fold:\u00b7"
else
  set listchars=tab:>-,trail:~,extends:>,precedes:<,nbsp:_
endif

set selection=inclusive
set virtualedit=block

set number
set numberwidth=3
set cursorline
set ruler
set showcmd
set laststatus=2
set colorcolumn=120

set hlsearch
set incsearch

set ignorecase
set smartcase

set scrolloff=3
set sidescrolloff=5
set scrolljump=1
set display+=lastline

set completeopt=longest,menu

set diffopt+=vertical

set ttimeout
set timeoutlen=250

set mouse=

set shell=/usr/bin/env\ zsh
set grepprg=grep\ -nH\ $*

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
augroup last_known_cursor_position
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

augroup filetype_settings
  autocmd FileType go     setlocal shiftwidth=8 tabstop=8 noexpandtab
  autocmd FileType python setlocal shiftwidth=4 tabstop=4
  autocmd FileType ruby   setlocal shiftwidth=2 tabstop=2
  autocmd FileType text   setlocal textwidth=120
  autocmd FileType yaml   setlocal shiftwidth=2 tabstop=2
augroup END

" === Plugins ===

" Airline (part 1)
let g:airline_powerline_fonts=1
let g:airline_highlighting_cache = 1

if !has('packages')
  " Load plugins on Vim < 8
  runtime pack/vendor/opt/pathogen/autoload/pathogen.vim
  execute pathogen#infect()
else
  " Load all packages on Vim >= 8
  packloadall
  " Ensure devicons is loaded after the plugins it modifies
  packadd devicons
endif

" Airline (part 2) / Tmuxline
if exists('g:loaded_airline') && g:loaded_airline
  let g:airline_theme='nord'

  let g:airline#extensions#ale#enabled=1
  let g:airline#extensions#ale#error_symbol="\uF467 "
  let g:airline#extensions#ale#warning_symbol="\uF421 "
  let g:airline#extensions#ale#show_line_numbers=1
  let g:airline#extensions#ale#open_lnum_symbol="(\uE0A1"
  let g:airline#extensions#ale#close_lnum_symbol=')'

  let g:airline#extensions#tabline#enabled=1
  let g:airline#extensions#tabline#show_buffers=0
  let g:airline#extensions#tabline#show_close_button=0
  let g:airline#extensions#tabline#show_tab_type=0

  let g:tmuxline_preset={
        \ 'a'       : '#h',
        \ 'b'       : '#S',
        \ 'win'     : ['#I', '#W', '#F'],
        \ 'cwin'    : ['#I', '#W', '#F'],
        \ 'z'       : '#T',
        \ 'options' : {'status-justify' : 'left'}
        \ }
endif

" ALE
let g:ale_echo_msg_error_str='E'
let g:ale_echo_msg_warning_str='W'
let g:ale_echo_msg_format='[%linter%] %s [%severity%]'
let g:ale_fix_on_save=1
let g:ale_fixers={
      \ 'rust': ['remove_trailing_lines', 'rustfmt', 'trim_whitespace'],
      \ 'terraform': ['remove_trailing_lines', 'terraform'],
      \ 'yaml': ['remove_trailing_lines', 'trim_whitespace'],
      \ }
let g:ale_linters={
      \ 'rust': ['analyzer'],
      \ }
let g:ale_linters_ignore={
      \ 'terraform': ['terraform'],
      \ }
let g:ale_python_flake8_options = '--max-line-length 120'
let g:ale_python_pylint_options = '--max-line-length 120'

" CSV
let g:csv_table_leftalign=1

" DevIcons
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" Gist
let g:gist_detect_filetype=1
let g:gist_open_browser_after_post=1
let g:gist_browser_command='sensible-browser %URL%'
let g:gist_clip_command='xclip -selection clipboard'
let g:gist_show_privates=1

" Go
let g:go_fmt_autosave=1
let g:go_fmt_command='goimports'
let g:go_fmt_fail_silently=1
let g:go_highlight_build_constraints=1
let g:go_highlight_fields=1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions=1
let g:go_highlight_methods=1
let g:go_highlight_operators=1
let g:go_highlight_types=1
let g:go_list_type='quickfix'

" Man
runtime ftplugin/man.vim

augroup man_plugin_settings
  autocmd FileType man setlocal nolist
augroup END

" Match It
runtime macros/matchit.vim

" NERDTree
runtime! nerdtree_plugin/webdevicons.vim

let NERDTreeIgnore=['\.pyc$', '\.zwc$', '\.zwc\.old$']
let NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable="\uF460"
let g:NERDTreeDirArrowCollapsible="\uF47C"

let g:NERDTreeIndicatorMapCustom={
      \ 'Modified'  : "\uF459 ",
      \ 'Staged'    : "\uF055 ",
      \ 'Untracked' : "\uF020 ",
      \ 'Renamed'   : "\uF45A ",
      \ 'Unmerged'  : "\uF440 ",
      \ 'Deleted'   : "\uF458 ",
      \ 'Dirty'     : "\uF41B ",
      \ 'Clean'     : "\uF42E ",
      \ 'Ignored'   : "\uF474 ",
      \ 'Unknown'   : "\uF46E "
      \ }

let g:DevIconsEnableFoldersOpenClose=1
let g:WebDevIconsNerdTreeBeforeGlyphPadding=''
let g:WebDevIconsNerdTreeGitPluginForceVAlign=1
let g:WebDevIconsUnicodeDecorateFolderNodes=1

highlight! link NERDTreeFlags NERDTreeDir

" NetRW
let g:netrw_http_cmd='curl -s -o'

" Python
let python_highlight_builtins=1
let python_highlight_exceptions=1
let python_highlight_numbers=1
let python_highlight_space_errors=1
let g:pymode_doc=0
let g:pymode_options=0
let g:pymode_lint_checkers=['pyflakes', 'pep8']
let g:pymode_options_max_line_length = 120
let g:pymode_lint_options_pep8 = {
    \ 'max_line_length': g:pymode_options_max_line_length
    \ }
let g:pymode_options_colorcolumn = 1
let g:pymode_python = 'python3'

" Ruby
let ruby_operators=1
let g:rubycomplete_buffer_loading=1
let g:rubycomplete_classes_in_global=1
let g:rubycomplete_rails=1

" Rust
let g:rust_fold=1
let g:rustfmt_autosave=1
let g:rustfmt_fail_silently=1

" Rails
let g:rails_gnu_screen=1
let g:rails_mappings=1
let g:rails_syntax=1

" Rainbow
" let g:rainbow_active=1

" Startify
let g:startify_change_to_vcs_root=1
let g:startify_custom_header=[]
let g:startify_session_persistence=1
let g:startify_skiplist=[
      \ 'COMMIT_EDITMSG',
      \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') . 'doc',
      \ $HOME . '/.vim/pack/.*/doc',
      \ '/vendor/',
      \ ]

" Terraform
let g:terraform_align=0
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=0

" UltiSnips
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsExpandTrigger='<C-j>'
let g:UltiSnipsListSnippets='<C-k>'
let g:UltiSnipsJumpBackwardTrigger='<C-j>'
let g:UltiSnipsJumpForwardTrigger='<C-k>'

" Workspace
let g:workspace_session_directory=$HOME . '/.vim/sessions/'

" YCM
let g:ycm_gopls_binary_path='gopls'
let g:ycm_language_server = [
      \   {
      \     'name': 'rust',
      \     'cmdline': ['rust-analyzer'],
      \     'filetypes': ['rust'],
      \     'project_root_files': ['Cargo.toml']
      \   }
      \ ]

" === Mappings ===

inoremap jj <Esc>

nnoremap <silent> <C-n> :NERDTreeToggle<CR>
set pastetoggle=<Leader>p

" ALE
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" FZF
nnoremap <C-p> :Files<CR>
nnoremap <Leader>ag :Ag <C-R><C-W><CR>
let $BAT_THEME = 'Nord'

" Markdown preview
nmap <silent> <C-m> <Plug>MarkdownPreviewToggle

" Workspace
nnoremap <Leader>s :ToggleWorkspace<CR>

" "" '' <> () [] {}
noremap! "" ""<esc>i
noremap! """ """"""<esc>hhi
noremap! '' ''<esc>i

noremap! << <><esc>i
noremap! </ </><esc>i
noremap! <</ </><esc>hi
noremap! <<! <!--  --><esc>hhhi
noremap! <% <%  %><esc>hhi
noremap! <%= <%=  %><esc>hhi

noremap! (( ()<left>
noremap! (<cr> (<cr>)<c-o>O
noremap! (; ();<esc>hi
noremap! (<cr>; (<cr>);<c-o>O
noremap! ('; ('');<esc>hhi
noremap! ("; ("");<esc>hhi
noremap! (' ('')<esc>hi
noremap! (" ("")<esc>hi

noremap! {{ {}<left>
noremap! {<cr> {<cr>}<c-o>O
noremap! {; {};<esc>hi
noremap! {<cr>; {<cr>};<c-o>O
noremap! {'; {''};<esc>hhi
noremap! {"; {""};<esc>hhi
noremap! {' {''}<esc>hi
noremap! {" {""}<esc>hi
noremap! {# {#  #}<esc>hhi
noremap! {% {%  %}<esc>hhi
noremap! {{% {{  }}<esc>hhi
noremap! {{{ {{{ }}}<esc>hhhi
noremap! {{{<cr> {{{ <cr>}}}<esc>kA

noremap! [[ []<left>
noremap! [<cr> [<cr>]<c-o>O
noremap! [; [];<esc>hi
noremap! [<cr>; [<cr>];<c-o>O
noremap! ['; [''];<esc>hhi
noremap! ["; [""];<esc>hhi
noremap! [' ['']<esc>hi
noremap! [" [""]<esc>hi

nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" === LOCAL ===

if filereadable(glob('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" vim:ft=vim:sw=2:ts=2:et
