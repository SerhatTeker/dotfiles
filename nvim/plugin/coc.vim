" coc.vim {{{

" Disable coc.vim for vim-go and deoplete.vim
augroup CocDisableGroup
  autocmd!
  autocmd BufNew,BufRead *.go execute "CocDisable"
augroup end

" Extension
let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-diagnostic',
    \ 'coc-eslint',
    \ 'coc-html',
    \ 'coc-jedi',
    \ 'coc-json',
    \ 'coc-sh',
    \ 'coc-sql',
    \ 'coc-snippets',
    \ 'coc-tsserver',
    \ ]

" Enable?
" 'coc-git'

" Disable for go since vim-go
" autocmd FileType go let b:coc_suggest_disable = 1

" Going To definition
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Displaying documentation (in the floating window)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Smart rename: renames the exports across all files
nmap <leader>rn <Plug>(coc-rename)
" }}}
