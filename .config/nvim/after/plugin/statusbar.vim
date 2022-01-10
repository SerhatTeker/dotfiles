" Statusbar {{{2

" Use airline or lightline
" Default one is airline
" Uncomment below to use airline, needed powerline fonts
" let g:status_bar = "airline"
let g:status_bar_choice = get(g:, 'status_bar', "lightline")

if g:status_bar_choice == "airline"
    if colors_name ==# "neodark"
        let g:airline_theme="onedark"
    elseif colors_name ==# "gruvbox"
        let g:airline_theme="gruvbox"
    elseif colors_name ==# "one"
        let g:airline_theme="one"
    else
        " let g:airline_theme=g:colors_name
        let g:airline_theme="onedark"
    endif
elseif g:status_bar_choice == "lightline"
    if colors_name ==# "gruvbox"
        let g:lightline.colorscheme="gruvbox"
    else
        " let g:lightline.colorscheme=g:color_theme
        let g:lightline.colorscheme="one"
    endif

    " if exists(":Tmuxline")
    "     :Tmuxline lightline
    " endif
endif
" }}}2
