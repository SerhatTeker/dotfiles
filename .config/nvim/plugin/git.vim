" gitgutter {{{
" A Vim plugin which shows git diff markers in the sign column
" and stages/previews/undoes hunks and partial hunks.

" disabled by default
let g:gitgutter_enabled = 0
" toggle with :GitGutterToggle
" toggle line highlighting :GitGutterLineHighlightsToggle
" With Neovim 0.3.2 or higher, toggle highlight line nr :GitGutterLineNrHighlightsToggle.

" Disable mappings, only use my customs
let g:gitgutter_map_keys = 0
nnoremap <leader>gg :GitGutterToggle<CR>
nmap <leader>gh <Plug>(GitGutterPreviewHunk)
" }}}
