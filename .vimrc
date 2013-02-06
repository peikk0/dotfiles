" peikk0's vimrc

execute pathogen#infect()

set nocompatible
set modeline
set modelines=5     " Debian likes to disable this

set backspace=indent,eol,start

set nobackup
set swapfile
set autoread

set title
set shortmess=aoOtTI
set wildmenu
set wildmode=longest:full,full

set viminfo='20,\"500,h
set history=50

set fileencodings=utf-8,latin1,default
set fileformats=unix,dos,mac

set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent

let showbreak="> "
set list
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
  let &listchars="tab:\u21e5\u2043,trail:\u2022,extends:\u21c9,precedes:\u21c7,nbsp:\u2423"
  let &fillchars="vert:\u259a,fold:\u00b7"
else
  set listchars=tab:>-,trail:~,extends:>,precedes:<,nbsp:_
endif

set selection=inclusive
set virtualedit=block

set nonumber
set numberwidth=3
set nocursorline
set ruler
set showcmd
set laststatus=2

set statusline=[%n]\ %<%f\ %y[%{&ff}][%{&fenc}]%h%w%r%m%{SL('fugitive#statusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%5l/%L%4c%V\ [0x%04B]

set hlsearch
set incsearch

set ignorecase
set smartcase

set scrolloff=3
set sidescrolloff=5
set scrolljump=1

set completeopt=longest,menu,preview

set diffopt+=vertical

set timeoutlen=250

set shell=/bin/sh
set grepprg=grep\ -nH\ $*
command -bar -nargs=1 OpenURL :!firefox <args>

if has("autocmd")
  filetype plugin indent on

  au!
  autocmd FileType text setlocal textwidth=78
  autocmd FileType c      set omnifunc=ccomplete#Complete
  autocmd FileType css    set omnifunc=csscomplete#CompleteCSS
  autocmd FileType html   set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType man    set nolist
  autocmd FileType php    set omnifunc=phpcomplete#CompletePHP
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType ruby   set omnifunc=rubycomplete#Complete
  autocmd FileType sql    set omnifunc=sqlcomplete#Complete
  autocmd FileType xml    set omnifunc=xmlcomplete#CompleteTags
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif

if has("terminfo")
  syntax enable
  set t_Co=256
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
  set background=dark
  colorscheme solarized
end

function! SL(function)
  if exists('*'.a:function)
    return call(a:function,[])
  else
    return ''
  endif
endfunction

" Plugins

" :Man command
runtime ftplugin/man.vim

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
let ruby_operators=1
let g:rubycomplete_buffer_loading=1
let g:rubycomplete_classes_in_global=1
let g:rubycomplete_rails=1

" rails
let g:rails_gnu_screen=1
let g:rails_mappings=1
let g:rails_syntax=1

" syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1

" Mappings

map <F5> <Esc>gg=G''
map <F6> :TlistToggle<Return>
map <F7> :TlistUpdate<Return>
map <F9> :DiffChangesDiffToggle<Return>
map <F10> :DiffChangesPatchToggle<Return>
map <A-Right> gt
map <A-Left> gT
set pastetoggle=<F11>

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

if exists(":nohls")
  nnoremap <silent> <C-L> :nohls<CR><C-L>
endif

