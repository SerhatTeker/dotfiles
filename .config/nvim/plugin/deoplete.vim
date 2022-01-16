" Deoplete.vim {{{
" Using it for only go

" let g:python3_host_prog = '/usr/bin/python3'
let g:deoplete#enable_at_startup = 1
" let g:deoplete#on_insert_enter = 1
" let g:deoplete#file#enable_buffer_path=1
" let g:deoplete#auto_complete = v:true
" let g:deoplete#auto_complete_popup = "auto"

augroup deopleteGo
    autocmd!
    autocmd FileType go call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
    autocmd FileType go call deoplete#custom#source('ale', 'rank', 999)
augroup END

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" <CR>: close popup
" https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" }}}
