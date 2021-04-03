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
"
" http://vimcasts.org/episodes/meet-neovim/
" All runtime files and packages in ~/.vim will be loaded by Neovim. Any
" customisations you make in your $MYNVIMRC will now apply to Neovim as well
" as Vim.
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" set guicursor =
source $MYNVIMRC

if filereadable(expand("$MYNVIMRC"))
	source $MYNVIMRC
" fallbacks
elseif filereadable(expand("~/.nvimrc"))
	source ~/.nvimrc
else
	source ~/.vimrc
endif
