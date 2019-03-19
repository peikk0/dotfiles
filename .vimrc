" peikk0's vimrc

" Load plugins on Vim 7
if !has("packages")
  runtime pack/vendor/opt/pathogen/autoload/pathogen.vim
  execute pathogen#infect()
endif

syntax on
filetype plugin indent on

if has("terminfo") || has("nvim")
  if has("packages")
    packadd base16
  endif
  set t_Co=256
  set background=dark
  let base16colorspace=256
  colorscheme base16-default-dark
end

set nocompatible
set modeline
set modelines=5 " Debian likes to disable this

set backspace=indent,eol,start

set nobackup
set noundofile
set swapfile
set autoread
set updatetime=100

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
set omnifunc=syntaxcomplete#Complete

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

set completeopt=longest,menu

set diffopt+=vertical

set timeoutlen=250

set mouse=

set shell=/bin/sh
set grepprg=grep\ -nH\ $*

function! OpenURL(url)
  if $DISPLAY !~ '^\w'
    exe "silent !sensible-browser \"".a:url."\""
  else
    exe "silent !sensible-browser -T \"".a:url."\""
  endif
  redraw!
endfunction
command! -nargs=1 OpenURL :call OpenURL(<q-args>)
" open URL under cursor in browser
nnoremap gb :OpenURL <cfile><CR>
nnoremap gG :OpenURL http://www.google.com/search?q=<cword><CR>
nnoremap gW :OpenURL http://en.wikipedia.org/wiki/Special:Search?search=<cword><CR>

if has("autocmd")
  autocmd FileType go         setlocal shiftwidth=8 tabstop=8 noexpandtab
  autocmd FileType html       setlocal shiftwidth=2 tabstop=2
  autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
  autocmd FileType man        setlocal nolist
  autocmd FileType ruby       setlocal shiftwidth=2 tabstop=2
  autocmd FileType text       setlocal textwidth=78
  autocmd FileType yaml       setlocal shiftwidth=2 tabstop=2

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif

" use XHTML and CSS with :TOhtml
let use_xhtml=1
let html_use_css=1
let html_ignore_folding=1
let html_use_encoding="UTF-8"



" === Plugins ===

" Load all packages on Vim >= 8
if has("packages")
  packloadall
endif

" airline
let g:airline_theme='base16_default'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = "\uE0C6"
" let g:airline_left_alt_sep = "\uE0C6"
let g:airline_right_sep = "\uE0C7"
" let g:airline_right_alt_sep = "\uE0C7"
let g:airline_section_z = airline#section#create(['%3p%%'.g:airline_symbols.space, "\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_type = 0

" csv
let g:csv_table_leftalign=1

" gist
let g:gist_detect_filetype=1
let g:gist_open_browser_after_post=1
let g:gist_browser_command='sensible-browser %URL%'
let g:gist_clip_command='xclip -selection clipboard'
let g:gist_show_privates=1

" Man
runtime ftplugin/man.vim

" Match It
runtime macros/matchit.vim

" NERDTree
let NERDTreeIgnore = ['\.pyc$']

if has("autocmd")
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
endif

function! NTFinderP()
  "" Check if NERDTree is open
  if exists("t:NERDTreeBufName")
    let s:ntree = bufwinnr(t:NERDTreeBufName)
  else
    let s:ntree = -1
  endif
  if (s:ntree != -1)
    "" If NERDTree is open, close it.
    :NERDTreeClose
  else
    "" Try to open a :Rtree for the rails project
    if exists(":Rtree")
      "" Open Rtree (using rails plugin, it opens in project dir)
      :Rtree
    else
      "" Open NERDTree in the file path
      :NERDTreeFind
    endif
  endif
endfunction

" netrw
let g:netrw_http_cmd="curl -s -o"

" Python
let python_highlight_builtins=1
let python_highlight_exceptions=1
let python_highlight_numbers=1
let python_highlight_space_errors=1
let g:pymode_doc=0
let g:pymode_options=0
let g:pymode_lint_checkers = ['pyflakes', 'pep8']

" Ruby
let ruby_operators=1
let g:rubycomplete_buffer_loading=1
let g:rubycomplete_classes_in_global=1
let g:rubycomplete_rails=1

" rails
let g:rails_gnu_screen=1
let g:rails_mappings=1
let g:rails_syntax=1

" rainbow
" let g:rainbow_active=1

" syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_puppet_checkers=["puppet"]
let g:syntastic_puppet_puppetlint_args="--error-level error"
let g:syntastic_php_checkers=['php']
let g:syntastic_python_checkers=[]
let g:syntastic_tex_checkers=[]

function! SL(function)
  if exists('*'.a:function)
    return call(a:function,[])
  else
    return ''
  endif
endfunction

set statusline=[%n]\ %<%f\ %y[%{&ff}][%{&fenc}]%h%w%r%m%{SL('fugitive#statusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%5l/%L%4c%V\ [0x%04B]

" terraform
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1

" === Mappings ===

inoremap jj <Esc>

map <silent> <F1> :call NTFinderP()<CR>
map <F5> <Esc>gg=G''
map <A-Right> gt
map <A-Left> gT
set pastetoggle=<F11>

" easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

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

if exists(":nohls")
  nnoremap <silent> <C-L> :nohls<CR><C-L>
endif

" === LOCAL ===

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" vim:ft=vim:sw=2:ts=2:et
