" peikk0's vimrc

set nocompatible

filetype plugin indent on
syntax on

if has('terminfo') || has('nvim')
  if has('packages')
    packadd base16
  endif
  set t_Co=256
  set background=dark
  let base16colorspace=256
  colorscheme base16-default-dark
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

let showbreak="> "
set list
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
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
set colorcolumn=80

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
set timeoutlen=100

set mouse=

set shell=/usr/bin/env\ zsh
set grepprg=grep\ -nH\ $*

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" === Plugins ===

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

" Airline / Tmuxline
if exists('g:loaded_airline') && g:loaded_airline
  let g:airline_theme='base16_default'
  let g:airline_powerline_fonts=1
  let g:airline_highlighting_cache = 1
  let g:airline_left_sep="\uE0C6"
  let g:airline_right_sep="\uE0C7"
  let g:airline_section_z=airline#section#create(['%3p%%'.g:airline_symbols.space, "\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])

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
  let g:tmuxline_separators={
        \ 'left'  : "\uE0C6",
        \ 'right' : "\uE0C7"
        \ }
endif

" ALE
let g:ale_echo_msg_error_str='E'
let g:ale_echo_msg_warning_str='W'
let g:ale_echo_msg_format='[%linter%] %s [%severity%]'

" CodeFmt
augroup autoformat_settings
  autocmd FileType c,cpp AutoFormatBuffer clang-format
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  " autocmd FileType python AutoFormatBuffer yapf
augroup END

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
let g:go_fmt_fail_silently=1
let g:go_highlight_functions=1
let g:go_highlight_methods=1
let g:go_highlight_fields=1
let g:go_highlight_types=1
let g:go_highlight_operators=1
let g:go_highlight_build_constraints=1
let g:go_list_type="quickfix"

" Man
runtime ftplugin/man.vim

autocmd FileType man setlocal nolist

" Match It
runtime macros/matchit.vim

" NERDTree
runtime! nerdtree_plugin/webdevicons.vim

let NERDTreeIgnore=['\.pyc$', '\.zwc$']
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

let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsNerdTreeBeforeGlyphPadding=''
let g:WebDevIconsNerdTreeGitPluginForceVAlign=1
let g:WebDevIconsUnicodeDecorateFolderNodes=1

highlight! link NERDTreeFlags NERDTreeDir

" NetRW
let g:netrw_http_cmd="curl -s -o"

" Python
let python_highlight_builtins=1
let python_highlight_exceptions=1
let python_highlight_numbers=1
let python_highlight_space_errors=1
let g:pymode_doc=0
let g:pymode_options=0
let g:pymode_lint_checkers=['pyflakes', 'pep8']

" Ruby
let ruby_operators=1
let g:rubycomplete_buffer_loading=1
let g:rubycomplete_classes_in_global=1
let g:rubycomplete_rails=1

" Rails
let g:rails_gnu_screen=1
let g:rails_mappings=1
let g:rails_syntax=1

" Rainbow
" let g:rainbow_active=1

" Startify
let g:startify_change_to_vcs_root=1
let g:startify_custom_header = []
let g:startify_session_persistence=1
let g:startify_skiplist=[
      \ 'COMMIT_EDITMSG',
      \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') . 'doc',
      \ $HOME . '/.vim/pack/.*/doc',
      \ ]

" Terraform
let g:terraform_align=0
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1

" === Mappings ===

if exists('Glaive')
  Glaive codefmt plugin[mappings]
endif

inoremap jj <Esc>

nnoremap <silent> <C-n> :NERDTreeToggle<CR>
set pastetoggle=<F11>

" ALE
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" FZF
nnoremap <C-p> :Files<CR>
nnoremap <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <Leader>rg :Rg <C-R><C-W><CR>

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
