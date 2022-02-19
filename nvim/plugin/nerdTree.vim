" NERDtree {{{

" Settings {{{

" show hiddens
let NERDTreeShowHidden=1

" Automatically close NerdTree when you open a file
" let NERDTreeQuitOnOpen = 1

" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" Disable that old “Press ? for help”.
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Ignore
let NERDTreeIgnore = [
            \ '\.pyc$',
            \ '^__pycache__$',
            \ '^.mypy_cache$',
            \ '^.pytest_cache$',
            \ '^.hypothesis$',
            \ '^htmlcov$',
            \ '\.retry$',
            \'^node_modules$',
            \]

" show bookmarkds
" let NERDTreeShowBookmarks=1

" To make sure vim does not open files and other buffers on NerdTree window
" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

let g:NERDTreeBookmarksFile=expand(localShare . '/.NERDTreeBookmarks')
" }}}

" NERDTree Mappings {{{
nmap <C-t> :NERDTreeToggle<CR>

" Directly open NerdTree on the file you’re editing
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
" }}}
" }}}
