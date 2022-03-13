" ChangeBackground {{{

" TODO: Put together with InitiateColorscheme
" ChangeBackground changes the background mode based on macOS's and Linux's `Appearance`
" setting. We also refresh the statusline colors to reflect the new mode.
function! ChangeBackground()
    " --- Linux ---
    if system("gsettings get org.gnome.desktop.interface gtk-theme") =~ "Yaru-light"
        set background=light
        colorscheme one
    endif

    " --- MacOS ---
    " TODO: Implement Fatih's method
    " https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/
    " if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
    "     set background=dark   " for the dark version of the theme
    " else
    "     set background=light  " for the light version of the theme
    " endif

    " check if the plugin exists and loaded
    if exists(":AirlineTheme")
        :AirlineRefresh
    endif
endfunction

" initialize the colorscheme for the first run
call ChangeBackground()

" change the color scheme if we receive a SigUSR1
autocmd Signal SIGUSR1 * call ChangeBackground()
" }}}

" Airline Statusbar Themes {{{

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
" }}}
