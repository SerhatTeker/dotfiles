" coc.vim {{{

" Core {{{

" " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" " delays and poor user experience.
" set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved.
" if has("nvim-0.5.0") || has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold *\(.py\)\@<! silent call CocActionAsync('highlight')
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" }}}

" Completion {{{

" <CR> {{{

" You have to remap <cr> to make it confirms completion.
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" To make <cr> select the first completion item and confirm the completion when no item has been selected:
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" }}}

" <Tab> <S-Tab> {{{

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
    " use <c-space>for trigger completion
    inoremap <silent><expr> <c-space> coc#refresh()
else
    " Use <C-@> on vim
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
" }}}
" }}}

" Custom Commands {{{

" Add `:CocFormat` command to format current buffer.
command! -nargs=0 CocFormat :call CocActionAsync('format')

" Add `:CocFold` command to fold current buffer.
command! -nargs=? CocFold :call CocAction('fold', <f-args>)

" Add `:CocImports` command for organize imports of the current buffer.
command! -nargs=0 CocImports   :call CocActionAsync('runCommand', 'editor.action.organizeImport')
" }}}

" Mappings {{{

" Go to definitions
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Smart rename: renames the exports across all files
nmap <leader>rn <Plug>(coc-rename)

" Custom commands
nnoremap <silent><nowait> <space>o :<C-u>CocOutline <CR>
nnoremap <silent><nowait> <space>f :<C-u>CocFormat <CR>

" Diagnostics: use `[d` and `]d` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Documantation: displaying documentation (in a floating window)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Map function and class text objects {{{

" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" }}}

" CocFzfList {{{

" Show all diagnostics.
nnoremap <silent><nowait> <space>d  :<C-u>CocFzfList diagnostics<CR>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocFzfList commands<CR>
" Find symbol of current document.
nnoremap <silent><nowait> <space>co  :<C-u>CocFzfList outline<CR>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocFzfList symbols<CR>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocFzfListResume<CR>
" Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocFzfList extensions<CR>
" }}}
" }}}

" Extensions {{{

let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-diagnostic',
    \ 'coc-eslint',
    \ 'coc-html',
    \ 'coc-jedi',
    \ 'coc-pyright',
    \ 'coc-json',
    \ 'coc-sh',
    \ 'coc-sql',
    \ 'coc-snippets',
    \ 'coc-tsserver',
    \ ]
" }}}

" python-pyright {{{

" Detect project root correctly
" https://github.com/fannheyward/coc-pyright/issues/521#issuecomment-858530052
autocmd FileType python let b:coc_root_patterns = [
            \'.git',
            \'.env',
            \'venv',
            \'.venv',
            \'setup.cfg',
            \'setup.py',
            \'pyproject.toml',
            \'pyrightconfig.json'
            \]
" }}}

" go-gopls {{{

" nmap <silent> <Enter> <Plug>(coc-definition)
" nmap <silent> <Leader>f <Plug>(coc-fix-current)

" Disable for go since vim-go
" autocmd FileType go let b:coc_suggest_disable = 1

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
