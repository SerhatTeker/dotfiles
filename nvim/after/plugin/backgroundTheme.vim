" ChangeBackground {{{

" ChangeBackground changes the background mode based on macOS's and Linux's
" `Appearance` setting. We also refresh the statusline colors to reflect the
" new mode.
function! ChangeBackground()
    " --- Linux ---
    if system("gsettings get org.gnome.desktop.interface gtk-theme") =~ "Yaru-light"
        let g:default_theme="one"
        let g:default_background="light"
    endif

    " --- MacOS ---
    if system("defaults read -g AppleInterfaceStyle") !~ '^Dark'
        let g:default_theme="one"
        let g:default_background="light"
    endif

    " check if the plugin exists and loaded
    if exists(":AirlineTheme")
        :AirlineRefresh
    endif

    call InitiateColors()                           " colors.vim
    " autocmd VimEnter * call InitiateColors()
endfunction

" initialize the colorscheme for the first run
call ChangeBackground()

" change the color scheme if we receive a SigUSR1
autocmd Signal SIGUSR1 * call ChangeBackground()
" }}}
