" auto-pair {{{

" Change defaults {{{

" 0. Add Python f,b,r strings
" 1. Delete single ", ', `
au Filetype * let g:AutoPairs = {
            \ '(':')',
            \ '[':']',
            \ '{':'}',
            \ "'":"'",
            \ '"':'"',
            \ '```':'```',
            \ '"""':'"""',
            \ "'''":"'''",
            \ "b'":"'",
            \ "f'":"'",
            \ "r'":"'"
            \ }
" }}}

" Toggle Autopairs disabled due to conflict {{{

let g:AutoPairsShortcutToggle = ''

" Not merged yet, can use related fork:
" Plug 'eapache/auto-pairs'
let g:AutoPairsUseInsertedCount = 1
let g:AutoPairsDelRepeatedPairs = 1

" Map <space> to insert a space after the opening character and before the closing one
let g:AutoPairsMapSpace = 0
" }}}
" }}}
