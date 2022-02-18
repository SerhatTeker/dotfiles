" Override : call go#def#StackPop(v:count1)
nnoremap <buffer> <silent> <C-t> :NERDTreeToggle<CR>
" Then use it on Nerd splitview as well
nnoremap <C-t> :NERDTreeToggle<CR>

colorscheme molokai

" check if the plugin exists and loaded
if exists(":AirlineTheme")
    let g:airline_theme = 'molokai'
    :AirlineRefresh
endif
