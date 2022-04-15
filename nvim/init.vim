" ----------------------------------------------------------------------------"
"
"                        _       _ _         _
"                       (_)_ __ (_) |___   _(_)_ __ ___
"                       | | '_ \| | __\ \ / / | '_ ` _ \
"                       | | | | | | |_ \ V /| | | | | | |
"                       |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"
"
" Author: Serhat Teker <serhat.teker@gmail.com>
" Source: https://github.com/SerhatTeker/dotfiles
" License: https://github.com/SerhatTeker/dotfiles
"
" ----------------------------------------------------------------------------"

" set guicursor =

if filereadable(expand('$MYNVIMRC'))
	source $MYNVIMRC
" fallbacks
elseif filereadable(expand('~/.config/nvim/.nvimrc'))
	source ~/.config/nvim/.nvimrc
else
	source ~/.vimrc
endif

lua require('config')
