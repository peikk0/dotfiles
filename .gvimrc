" set gui options
set guioptions=ac

" change font in gui
if has("mac")
    set guifont=Menlo:h12
elseif has("unix")
    set guifont=Fira\ Code\ 10
endif

" syntax hilighting
syntax on

" set a custom color scheme
set background=dark
colorscheme solarized

" no space between lines
set linespace=0

" columns & lines
set columns=120
set lines=35

" mouse behaviour
set mouse=
"set mousemodel=extend

" keyboard behaviour
set winaltkeys=no
