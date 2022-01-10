" Statusbar Themes {{{2

if g:colors_name ==# "neodark"
    let g:airline_theme="onedark"
elseif g:colors_name ==# "gruvbox"
    let g:airline_theme="gruvbox"
elseif g:colors_name ==# "one"
    let g:airline_theme="one"
else
    " let g:airline_theme=g:colors_name
    let g:airline_theme="onedark"
endif
" }}}2
