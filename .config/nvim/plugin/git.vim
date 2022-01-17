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
nnoremap <leader>gt :GitGutterToggle<CR>
nmap <leader>gh <Plug>(GitGutterPreviewHunk)
" }}}

" fugitive {{{

" Status
nnoremap <silent>ss :20G<CR>
" Do commit
nnoremap <silent>cc :Git commit<CR>
" Do push
nnoremap <leader>pp :Git push<CR>

" Show Commits
nnoremap <leader>gc :Commits!<CR>
" Show Buffer Commits
nnoremap <leader>gbc :BCommits!<CR>

" Show History
nnoremap <silent>HH :Gclog<CR>
" Show File History
nnoremap <silent>HF :0Gclog!<CR>

" Git diff current and previous version
nmap <leader>d :Gvdiffsplit HEAD<CR>
" always open diffs vertical
set diffopt+=vertical

" Custom{{{

" Amend aliases
command! GCN :Git commit -v --no-edit --amend
command! GCAN :Git commit -v -a --no-edit --amend

" Push set upstream
command! GPSUP :!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD 2>/dev/null)
" }}}
" }}}

" fzf-checkout{{{

nnoremap <leader>gb :GBranches<CR>
" }}}
