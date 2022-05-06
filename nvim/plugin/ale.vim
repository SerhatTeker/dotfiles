" ALE {{{2

" Settings {{{

" autofix on save
" let g:ale_fix_on_save = 1

" run linters only when saved file
""check your files as you make changes.
let g:ale_lint_on_text_changed = 0
"" run linters when you leave insert mode.
let g:ale_lint_on_insert_leave = 0
"" Check files when saved
let g:ale_lint_on_save = 1

" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

" Disabled, conflicting with 0Gclog from vim-fugitive
" use quickfix for errors
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1

" linters
let g:ale_linters = {
            \ 'python': ['flake8', 'mypy',],
            \ 'javascript': ['eslint'],
            \ 'html': ['prettier'],
            \ 'go': ['gopls'],
            \}

" fixers
let g:ale_fixers = {
            \ 'javascript': ['eslint'],
            \ 'html': ['tidy'],
            \ 'sh': ['shfmt'],
            \ 'python': [
                \ 'black',
                \ 'isort',
            \],
            \}
" }}}

" signs {{{

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
" defaults
" let g:ale_sign_error = '>>'
" let g:ale_sign_warning = '--'

highlight link ALEErrorSign SpellBad
highlight link ALEWarningSign WarningMsg
" }}}

" msg {{{

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_warning_str = 'W'

highlight link ALEError SpellBad
highlight link ALEWarning WarningMsg

let g:ale_echo_msg_format = '[%linter%] %severity% | %code% - %s'
" }}}

" mappings {{{3

" navigate errors
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)

" toggle buffers for
nmap <silent> <leader><C-c> <Plug>(ale_toggle_buffer)

" Bind F8 to fixing problems with ALE
nmap <F8> <Plug>(ale_fix)

" Use ALEFix with Autoflake
" nmap <silent> <F8> :call AleFixCustom()<CR>
" function! AleFixCustom()
"     if &filetype == "python"
"         if exists("*Autoflake()")
"             noremap <buffer> <leader><F9> :call Autoflake()<CR>
"             silent! call Autoflake()
"         endif
"     endif
"     execute 'ALEFix'
" endfunction
" }}}3
" }}}2
