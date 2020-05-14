" indentation {{{

setlocal	expandtab
setlocal	tabstop=4
setlocal	shiftwidth=4
setlocal	softtabstop=4
" }}}

" fold {{{

" setlocal	foldmethod=indent
" setlocal	foldignore=
" setlocal	autoindent
" }}}

" python-syntax {{{

let g:python_highlight_all = 1
" let python_highlight_all = "on"
" }}}

" simply-fold {{{

" ACHTUNG!!!
" If you have the above options set to different values anywhere (e.g. setting
" foldmethod=syntax in .vimrc, SimpylFold won't work properly.

" options
" let g:SimpylFold_docstring_preview = 1
" }}}

" vim-pythonsense {{{

" override default mappings
map <buffer> ]c <Plug>(PythonsenseStartOfNextPythonClass)
map <buffer> ]C <Plug>(PythonsenseEndOfPythonClass)
map <buffer> [c <Plug>(PythonsenseStartOfPythonClass)
map <buffer> [C <Plug>(PythonsenseEndOfPreviousPythonClass)
" }}}

" theme {{{
" TODO: Del if no need
" if (has("autocmd"))
" 	augroup colorextend
" 		autocmd!
" 		" Make `Function`s bold in GUI mode
" 		autocmd ColorScheme * call onedark#extend_highlight("Function", { "fg": { "cterm": 128 }})
" 	augroup END
" endif
" }}}
