" auto-pair {{{
" https://github.com/jiangmiao/auto-pairs/blob/master/plugin/auto-pairs.vim

" Pairs {{{

" All
" 0. Add Python f,b,r strings
" 1. Delete single ", ', `
au Filetype * let g:AutoPairs = {
            \ '(':')',
            \ '[':']',
            \ '{':'}',
            \ "'":"'",
            \ '"':'"',
            \ '`':'`',
            \ '```':'```',
            \ '"""':'"""',
            \ "'''":"'''",
            \ "b'":"'",
            \ "f'":"'",
            \ "r'":"'"
            \ }

" Only Parenthesis
" au Filetype * let g:AutoPairs = {
"             \ '(':')',
"             \ '[':']',
"             \ '{':'}'
"             \ }
" }}}

" Toggle {{{

" Toggle Autopairs disabled due to conflict
let g:AutoPairsShortcutToggle = ''
" Key mapping not working properly, manually map
inoremap <leader>tp <ESC>:call AutoPairsToggle()<CR>i
noremap <leader>tp :call AutoPairsToggle()<CR>
" }}}

" Pair count issue {{{

" https://github.com/jiangmiao/auto-pairs/issues/164
" https://github.com/jiangmiao/auto-pairs/pull/71
" #71 Not merged yet, can use related fork:
" https://github.com/eapache/auto-pairs
let g:AutoPairsUseInsertedCount = 1
let g:AutoPairsDelRepeatedPairs = 1
" }}}

" Map <space> to insert a space after the opening character and before the closing one
let g:AutoPairsMapSpace = 0
" }}}
