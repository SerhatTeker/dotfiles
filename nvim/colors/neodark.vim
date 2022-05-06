"                       _            _           _
"  _ __   ___  ___   __| | __ _ _ __| | ____   _(_)_ __ ___
" | '_ \ / _ \/ _ \ / _` |/ _` | '__| |/ /\ \ / / | '_ ` _ \
" | | | |  __/ (_) | (_| | (_| | |  |   < _\ V /| | | | | | |
" |_| |_|\___|\___/ \__,_|\__,_|_|  |_|\_(_)\_/ |_|_| |_| |_|
"
" Author: Serhat Teker <serhat.teker@gmail.com>
" Source: https://github.com/SerhatTeker/dotfiles
"
" Custom Colorscheme Based on onedark.vim

" -----------------------------------------------------------------------------"
" Custom {{{
" -----------------------------------------------------------------------------"

" Create a color scheme based on another
" https://vim.fandom.com/wiki/Create_a_color_scheme_based_on_another
" these lines are suggested to be at the top of every colorscheme
highlight clear
if exists("syntax_on")
  syntax reset
endif

" https://neovim.io/doc/user/syntax.html#:colorscheme
"Load the 'base' colorscheme - the one you want to alter
runtime colors/onedark.vim

"Override the name of the base colorscheme with the name of this custom one
let g:colors_name = "neodark"
" -----------------------------------------------------------------------------"
" }}}1
" -----------------------------------------------------------------------------"

" -----------------------------------------------------------------------------"
" Highlight	{{{
" -----------------------------------------------------------------------------"

"Clear the colors for any items that you don't like
highlight clear Normal

" Set up your new & improved colors

" Reset the background color in Normal mode so vim uses Terminal.app's
" background color. Get bg from tmux bg
highlight Normal ctermfg=145 guifg=#ABB2BF guibg=none
" default hi Normal:
" highlight Normal ctermfg=145 ctermbg=234 guifg=#ABB2BF guibg=#1c1c1c

" Active/Inactive Window Colors in NeoVim {{{

if (has("nvim"))
    hi ActiveWindow guibg=none
    hi InactiveWindow guibg=#303030

    " Call method on window enter
    augroup WindowManagement
      autocmd!
      autocmd WinEnter * call Handle_Win_Enter()
    augroup END

    " Change highlight group of active/inactive windows
    function! Handle_Win_Enter()
      setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
    endfunction
endif
" }}}

" Custom Highlight for Python
highlight CusConst ctermfg=215 guifg=#ffaf5f
" Vscode constant
" highlight CusConst ctermfg=214 guifg=#d19a66
" -----------------------------------------------------------------------------"
" }}}1
" -----------------------------------------------------------------------------"
