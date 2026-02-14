" ----------------------------------------------------------------------------"
"	Colors		{{{
" ----------------------------------------------------------------------------"
"
" Colors initiated from ChangeBackground() in backgroundTheme.vim
"
"  Colors controlled from:
"  * colors.vim : defines defaults
"  * backgroundTheme.vim : update theme according to OS theme change
"
" Default theme is **neodark** and background is **dark** defined in colors.vim
" Light theme is **one**
" Theme change controlled by ChangeBackground() from backgroundTheme.vim


" Global color theme and background choice
let g:default_theme="neodark"
let g:default_background="dark"

" colors settings {{{

" https://github.com/morhetz/gruvbox/wiki/Terminal-specific#0-recommended-neovimvim-true-color-support
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
" if (empty($TMUX))
if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
    set termguicolors
endif
" endif
" }}}

" Cursor {{{

" Default Cursor
set guicursor=
    \n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor50

" Cursor w/ blink
" set guicursor=
"     \n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor50
"     \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
"     \,sm:block-blinkwait175-blinkoff150-blinkon175

" Reset shape while exiting to terminal
" https://github.com/neovim/neovim/issues/6005
augroup Shape
    autocmd!
    autocmd VimLeave * set guicursor=
        \n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor50
        \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
        \,sm:block-blinkwait175-blinkoff150-blinkon175
augroup END
" }}}

" InitiateColors {{{

" Used in ChangeBackground
function! InitiateColors()

    " Background {{{

    if g:default_background ==# "dark"
        set background=dark
    else
        set background=light
    endif
    " }}}

    " Colorscheme and airline theme {{{

    " check base16 theme exists
    if filereadable(expand("~/.vimrc_background"))
        let base16colorspace=256
        source ~/.vimrc_background
    else
        if g:default_theme ==# "neodark"
            colorscheme neodark

            let g:airline_theme="onedark"

            " Custom Cursor {{{

            " define custom cursor highlight
            hi Cursor guibg=yellow
            setlocal guicursor=
                        \n-v-c:block-Cursor/lCursor
                        \,i-ci-ve:block-Cursor/lCursor
                        \,r-cr-o:hor50-Cursor/lCursor
            " }}}

        elseif g:default_theme ==# "gruvbox"
            let g:gruvbox_contrast_dark = "hard"
            let g:gruvbox_contrast_light = "hard"
            colorscheme gruvbox

            let g:airline_theme="gruvbox"

        elseif g:default_theme ==# "one"
            colorscheme one

            let g:airline_theme="one"
        else
            colorscheme onedark
            let g:onedark_color_overrides = {
                        \ "black": {"gui": "#0b0b0b", "cterm": "233", "cterm16": "0" },
                        \}
        endif
    endif
    " }}}
endfunction
" }}}
" ----------------------------------------------------------------------------"
"	}}}
" ----------------------------------------------------------------------------"
