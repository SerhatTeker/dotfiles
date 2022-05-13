" coc.vim {{{

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

" Smart rename: renames the exports across all files
nmap <leader>rn <Plug>(coc-rename)

" Displaying documentation (in the floating window)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
" }}}

" coc-go {{{

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" https://github.com/fatih/vim-go/issues/2888#issuecomment-632161362
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" nmap <silent> <Enter> <Plug>(coc-definition)
" nmap <silent> <Leader>r <Plug>(coc-references)
" nmap <silent> <Leader>f <Plug>(coc-fix-current)

" go {{{

" " Disable coc.vim for vim-go and deoplete.vim
" function! s:disable_coc_for_type()
"     let l:filesuffix_blacklist = [
"         \ 'go',
"         \ ]
"     if index(l:filesuffix_blacklist, expand('%:e')) != -1
"         let b:coc_enabled = 0
"     endif
" endfunction

" augroup CocDisableGroup
"     autocmd!
"     autocmd BufRead,BufNewFile * call s:disable_coc_for_type()
"     " autocmd BufNew,BufRead *.go execute "CocDisable"
" augroup end
" }}}
" }}}
