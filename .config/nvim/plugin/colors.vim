" ----------------------------------------------------------------------------"
"	Colors		{{{
" ----------------------------------------------------------------------------"

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
set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor50

" https://github.com/neovim/neovim/issues/6005
" augroup Shape autocmd! autocmd VimLeave * set guicursor=a:block augroup END
" }}}

" InitiateColorscheme {{{

" Using ChangeBackground
function! InitiateColorscheme()
    " check base16 theme
    if filereadable(expand("~/.vimrc_background"))
        let base16colorspace=256
        source ~/.vimrc_background
    elseif filereadable(expand("~/.config/nvim/colors/neodark.vim"))
    " elseif !isdirectory($VIMRUNTIME . '/colors/neodark.vim')
        " Onedark
        colorscheme neodark
        set background=dark

        " " Cursor {{{

        " " define cursor for `Normal` mode
        " hi Cursor guibg=yellow
        " " define cursor for `Insert` mode
        " hi Cursor2 guibg=yellow
        " setlocal guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:block-Cursor2/lCursor2,r-cr-o:hor50
        " " }}}
    else
        " gruvbox {{{

        let g:gruvbox_contrast_dark = "hard"
        let g:gruvbox_contrast_light = "hard"

        colorscheme gruvbox
        set background=dark
        " }}}

        " Onedark
        " set background=dark
        " colorscheme onedark
        " let g:onedark_color_overrides = {
        "             \ "black": {"gui": "#1b1b1b", "cterm": "233", "cterm16": "0" },
        "             \}

        " One
        " colorscheme one
        " set background=light
    endif
endfunction

call InitiateColorscheme()
" autocmd VimEnter * call InitiateColorscheme()
" }}}
" ----------------------------------------------------------------------------"
"	}}}
" ----------------------------------------------------------------------------"
