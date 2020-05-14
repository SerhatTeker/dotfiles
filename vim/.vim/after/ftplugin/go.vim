" indentation
setlocal	noexpandtab
setlocal	tabstop=8
setlocal	shiftwidth=8
setlocal	softtabstop=8

" Colors {{{

" to ensure that Vim uses 256 colors
" https://stackoverflow.com/a/15376154/10802538
setlocal t_Co=256
let rehash256 = 1
let molokai_original = 1

" Colorscheme
colorscheme solokai

" airline
if exists(':AirlineTheme') " check if the plugin is loaded
	:AirlineTheme molokai
else
	let airline_theme = 'molokai'
endif
" }}}
