"            _       _         _       _
"  ___  ___ | | ___ | | ____ _(_)_   _(_)_ __ ___
" / __|/ _ \| |/ _ \| |/ / _` | \ \ / / | '_ ` _ \
" \__ \ (_) | | (_) |   < (_| | |\ V /| | | | | | |
" |___/\___/|_|\___/|_|\_\__,_|_(_)_/ |_|_| |_| |_|
"
" Author: Serhat Teker <serhat.teker@gmail.com>
" Source: https://github.com/SerhatTeker/system-bak
"
" Custom Colorscheme Based on molokai.vim


" -----------------------------------------------------------------------------"
" Custom {{{1
" -----------------------------------------------------------------------------"

" Create a color scheme based on another
" https://vim.fandom.com/wiki/Create_a_color_scheme_based_on_another
" these lines are suggested to be at the top of every colorscheme
highlight clear
if exists("syntax_on")
  syntax reset
endif

"Load the 'base' colorscheme - the one you want to alter
runtime colors/molokai.vim

"Override the name of the base colorscheme with the name of this custom one
let g:colors_name = "solokai"
" -----------------------------------------------------------------------------"
" }}}1
" -----------------------------------------------------------------------------"

" -----------------------------------------------------------------------------"
" Highlight	{{{1
" -----------------------------------------------------------------------------"

"Clear the colors for any items that you don't like
highlight clear Normal

" Set up your new & improved colors
highlight Normal ctermfg=252 ctermbg=none guifg=#F8F8F2 guibg=none
" default hi Normal:
" highlight Normal ctermfg=145 ctermbg=234 guifg=#ABB2BF guibg=#1c1c1c
" -----------------------------------------------------------------------------"
" }}}1
" -----------------------------------------------------------------------------"

" -----------------------------------------------------------------------------"
" Cursor	{{{1
" -----------------------------------------------------------------------------"

" define cursor for `Normal` mode
hi Cursor guibg=yellow
" define cursor for `Insert` mode
hi Cursor2 guibg=yellow
set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:block-Cursor2/lCursor2,
" -----------------------------------------------------------------------------"
" }}}1
" -----------------------------------------------------------------------------"

" -----------------------------------------------------------------------------"
" Custom syntax {{{1
" -----------------------------------------------------------------------------"
" FIXME: not highlighting
" highlight sTodo ctermfg=15 guifg=#ffffff ctermbg=39 guibg=#61AFEF
" highlight sFixme cterm=bold ctermfg=160 guifg=#d70000
" highlight sBug cterm=bold ctermfg=15 ctermbg=9 guibg=#ff0000

" " Highlight
" " TODO Group
" syntax match sTodo /TODO/
" syntax match sFixme /FIXME/
" syntax match sBug /BUG/
" syn match   sTodo   contained   "\<\(TODO\|FIXME\):"
" read :echo &runtimepath
" -----------------------------------------------------------------------------"
" }}}1
" -----------------------------------------------------------------------------"
