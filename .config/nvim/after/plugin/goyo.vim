function! s:goyo_enter()
    " Disable neodark active/inactive widnow behaviour
    if g:colors_name ==# "neodark"
        hi ActiveWindow guibg=none
        hi InactiveWindow guibg=none
    endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
