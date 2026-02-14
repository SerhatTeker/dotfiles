" autoflake {{{
" Removes unused imports and unused variables as reported by pyflakes
" https://github.com/myint/autoflake
" https://github.com/tell-k/vim-autoflake

" Remove mapping
let g:no_autoflake_maps=1

" no need: using in AleFixCustom()
map <leader><F3> :call Autoflake()<CR>

" Remove all unused imports, whether or not they are from the standard library
let g:autoflake_remove_all_unused_imports=1
let g:autoflake_remove_unused_variables=0
let g:autoflake_disable_show_diff=0
" }}}

" Semshi {{{

"Mark selected nodes (those with the same name and scope as the one under the
"cursor). Set to 2 to highlight the node currently under the cursor, too.
let g:semshi#mark_selected_nodes = 1
" Show a sign in the sign column if a syntax error occurred.
let g:semshi#error_sign = v:true
" Delay in seconds until the syntax error sign is displayed. (A low delay time
" may distract while typing.)
let g:semshi#error_sign_delay = 1.5
" Factor to delay updating of highlights. Updates will be delayed by factor *
" number of lines second
let g:semshi#update_delay_facto = 0.0


" Custom colors suitable for OneDark theme
function! SemshiCustomHighlights()
    hi semshiBuiltin            guifg=#56B6C2
    hi semshiGlobal             guifg=NONE
    hi semshiSelf               guifg=#e6c07b
    hi semshiSelected           guifg=#ffffff guibg=#ABB2BF
    hi semshiAttribute          guifg=#e06c75

    hi semshiParameter          guifg=#D19A66                       " Default Parameter
    hi semshiParameterUnused    guifg=#895829 gui=underline,italic

    " Alternative
    " hi semshiParameter          guifg=#E06C75                     " Parameter Pylance style
    " hi semshiParameterUnused    guifg=#7e1b23 gui=underline,italic
endfunction

augroup semshiCustomHighlight
    au!
    autocmd BufEnter <buffer> call SemshiCustomHighlights()
augroup END
" }}}

" vim-pydocstring {{{

" TODO: make dynamic
let g:pydocstring_doq_path = '~/.local/bin/doq'
let g:pydocstring_formatter = 'google'
nmap <silent> <C-_> <Plug>(pydocstring)
" }}}

" fold {{{

" setlocal	foldmethod=indent
" setlocal	foldignore=
" setlocal	autoindent

" simply-fold {{{

" ACHTUNG!!!
" If you have the above options set to different values anywhere (e.g. setting
" foldmethod=syntax in .vimrc, SimpylFold won't work properly.

" options
" let g:SimpylFold_docstring_preview = 1
" }}}
" }}}

" python-syntax {{{

let g:python_highlight_all = 1
" let python_highlight_all = "on"
" }}}

" vim-pythonsense {{{

" override default mappings
map <buffer> ]c <Plug>(PythonsenseStartOfNextPythonClass)
map <buffer> ]C <Plug>(PythonsenseEndOfPythonClass)
map <buffer> [c <Plug>(PythonsenseStartOfPythonClass)
map <buffer> [C <Plug>(PythonsenseEndOfPreviousPythonClass)
" }}}

" Ale and coc.vim {{{

" https://github.com/dense-analysis/ale#5iii-how-can-i-use-ale-and-cocnvim-together
let b:ale_disable_lsp = 1
" }}}
