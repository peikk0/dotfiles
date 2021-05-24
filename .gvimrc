" set gui options
set guioptions=ac

" change font in gui
if has('mac')
    set guifont=FiraCode\ Nerd\ Font:h12
elseif has('unix')
    set guifont=FiraCode\ Nerd\ Font\ 10
endif

" keyboard behaviour
set winaltkeys=no
