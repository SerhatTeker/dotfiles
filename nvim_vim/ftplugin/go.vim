" vim-go {{{

" core settings {{{

let g:go_test_show_name = 1
let g:go_list_type = "quickfix"

let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
" Enable `go to definition/GoDef` mapping
let g:go_def_mapping_enabled = 1

let g:go_imports_autosave=1

let g:go_gopls_complete_unimported = 1

" Consider performance
" let g:go_auto_type_info = 1

" Highlight other uses of same keyword/id - Consider performance
" let g:go_auto_sameids = 1

" https://github.com/dense-analysis/ale/issues/609#issuecomment-305609209
" let g:go_fmt_fail_silently = 1

" Doc window instead of preview bottom
let g:go_doc_popup_window = 1
" }}}

" Folding {{{

" Enable
" setlocal foldmethod=syntax
" let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment'] " Default

" Disable
let g:go_fold_enable = []

" let g:go_fmt_experimental = 1
" }}}

" Highlight {{{

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
" }}}

" build function {{{

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction
" }}}

" mapping extra {{{

nmap <silent> <Leader>dt <Plug>(go-def-tab)
nmap <silent> <Leader>dv <Plug>(go-def-vertical)
nmap <silent> <Leader>ds <Plug>(go-def-split)

nmap <silent> <Leader>db <Plug>(go-doc-browser)
nmap <silent> <Leader>dx <Plug>(go-doc-vertical)

nmap <silent> <Leader>i <Plug>(go-info)
nmap <silent> <Leader>l <Plug>(go-metalinter)

nmap <silent> <leader>b :<C-u>call <SID>build_go_files()<CR>
nmap <silent> <leader>r  <Plug>(go-run)
nmap <silent> <leader>e  <Plug>(go-install)
nmap <silent> <leader>t  <Plug>(go-test)

nmap <silent> <Leader>c <Plug>(go-coverage-toggle)

" :GoAlternate  commands :A, :AV, :AS and :AT
command! -bang A call go#alternate#Switch(<bang>0, 'edit')
command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
command! -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
" }}}
" }}}
