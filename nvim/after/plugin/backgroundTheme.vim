" ChangeBackground {{{

" ChangeBackground changes the background mode based on macOS's and Linux's
" `Appearance` setting. We also refresh the statusline colors to reflect the
" new mode.
function! ChangeBackground()

    " Check OS
    if has("unix")
        " --- MacOS ---
        if has("mac") || has("macunix")
            if system("defaults read -g AppleInterfaceStyle") !~ '^Dark'
                let g:default_background="light"
                let g:default_theme="one"
            else
                let g:default_background="dark"
                let g:default_theme="neodark"
            endif
        " --- Linux ---
        else
            if system("gsettings get org.gnome.desktop.interface gtk-theme") =~ "Yaru-light"
                let g:default_background="light"
                let g:default_theme="one"
            else
                let g:default_background="dark"
                let g:default_theme="neodark"
            endif
        endif
    endif

    call InitiateColors()                           " colors.vim
    " autocmd VimEnter * call InitiateColors()

    " check if the plugin exists and loaded
    if exists(":AirlineTheme")
        :AirlineRefresh
        call AirlineInit()
    endif
endfunction

" initialize the colorscheme for the first run
call ChangeBackground()

" Add custom command for ChangeBackground()
command! AdaptGlobalTheme :call ChangeBackground()

" change the color scheme if we receive a SigUSR1
" autocmd Signal SIGUSR1 * call ChangeBackground()
autocmd Signal SIGUSR1 * execute AdaptGlobalTheme
" }}}
