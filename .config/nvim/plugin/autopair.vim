" auto-pair {{{

" Change defaults {{{

" Defaults
" au Filetype * let b:AutoPairs={'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}

" Change defaults
" au Filetype * let b:AutoPairs={'(':')', '[':']', '{':'}'}

" Add Python f,b,r strings
au Filetype * let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '```':'```', '"""':'"""', "'''":"'''", "`":"`", "b'":"'", "f'":"'", "r'":"'"}
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
