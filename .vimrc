" peikk0's vimrc

execute pathogen#infect()

" don't be vi compatible
set nocompatible

" use modelines
set modeline

" window title
set title

" short messages
set shortmess=aoOtTI

" viminfo file
set viminfo='20,\"500,h
" keep 50 lines of command history
set history=50

" tab == 4 space char
set shiftwidth=4
set expandtab
set smarttab

" automagic indenting
set autoindent
set smartindent

" special chars
set list
set listchars=tab:>-,trail:~,nbsp:_
set showbreak=>\ 

" allow backspace in insert mode
set backspace=indent,eol,start

" selection behaviour
set selection=inclusive

" numbered lines
set nonumber
set numberwidth=3

" show cursor position
set ruler
" show command on the bottom
set showcmd
" status line
set laststatus=1

" hilight search
set hlsearch
" search as I type
set incsearch
" ignore case when searching
set ignorecase
" override ignorecase if there are caps
set smartcase

" 3 lines visible around the cursor
set scrolloff=3
set sidescrolloff=5
set scrolljump=1

" completion
set completeopt=longest,menu,preview

" diffing
set diffopt+=vertical

" french spelling (activated with :set spell)
setlocal spelllang=fr

" use sh instead of zsh
set shell=/bin/sh

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

  augroup END

  autocmd FileType c      set omnifunc=ccomplete#Complete
  autocmd FileType css    set omnifunc=csscomplete#CompleteCSS
  autocmd FileType html   set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType man    set nolist
  autocmd FileType php    set omnifunc=phpcomplete#CompletePHP
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType ruby   set omnifunc=rubycomplete#Complete
  autocmd FileType sql    set omnifunc=sqlcomplete#Complete
  autocmd FileType xml    set omnifunc=xmlcomplete#CompleteTags

endif " has("autocmd")

" hilight current line
set nocursorline

if has("terminfo")
  syntax enable
  set t_Co=256
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
  set background=dark
  colorscheme solarized
end

" some usefull key mapping
map <F5> <Esc>gg=G''
map <F6> :TlistToggle
map <F7> :TlistUpdate
map <F9> :DiffChangesDiffToggle
map <F10> :DiffChangesPatchToggle
map <A-Right> gt
map <A-Left> gT
" paste/nopaste
set pastetoggle=<F11>

" force file encoding
set fileencodings=utf-8,latin1,default

" no backup
set nobackup

" swapfile
set swapfile

" :Man command
runtime ftplugin/man.vim

" grep command
set grepprg=grep\ -nH\ $*

" open urls with firefox
command -bar -nargs=1 OpenURL :!firefox <args>

" "" '' <> () [] {}
noremap! "" ""<esc>i
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

" don't open http links with elinks, but with wget instead
let g:netrw_http_cmd="wget -q -O"

" use XHTML and CSS with :TOhtml
let use_xhtml=1
let html_use_css=1
let html_ignore_folding=1
let html_use_encoding="UTF-8"

" Lua
let lua_version=5
let lua_subversion=1

" Python
let python_highlight_builtins=1
let python_highlight_exceptions=1
let python_highlight_numbers=1
let python_highlight_space_errors=1

" Ruby
let ruby_fold=1
let ruby_operators=1
let ruby_space_errors=1
let g:rubycomplete_buffer_loading=1
let g:rubycomplete_classes_in_global=1
let g:rubycomplete_rails=1

" rails.vim
let g:rails_gnu_screen=1
let g:rails_mappings=1
let g:rails_statusline=1
let g:rails_syntax=1
