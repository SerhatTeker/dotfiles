" indentation
setlocal	noexpandtab
setlocal	tabstop=8
setlocal	shiftwidth=8
setlocal	softtabstop=8

" Override : call go#def#StackPop(v:count1)
nnoremap <buffer> <silent> <C-t> :NERDTreeToggle<CR>
" Then use it on Nerd splitview as well
nnoremap <C-t> :NERDTreeToggle<CR>

" Colors {{{

" Colorscheme
colorscheme solokai

" status bar
if g:status_bar_choice == 'airline'
    let g:airline_theme = 'molokai'
else
    let g:lightline.colorscheme = 'molokai'
endif
" }}}
