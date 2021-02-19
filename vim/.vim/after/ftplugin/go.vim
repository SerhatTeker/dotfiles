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
    " let g:airline_theme = 'molokai'
    :AirlineTheme molokai
    " Add Refresh since colors mixed after udpate global color:'one'
    :AirlineRefresh
else
    let g:lightline.colorscheme = 'molokai'

    " LightlineRefresh {{{
    " Add LightlineRefresh like AirlineRefresh
    command! LightlineRefresh call LightlineRefresh()

    function! LightlineRefresh()
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
    endfunction
    " }}}

    " Add Refresh since colors mixed after udpate global color:'one'
    :LightlineRefresh
endif
" }}}
