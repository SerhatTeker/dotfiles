" fugitive {{{

" Status
nnoremap <silent>ss :G<CR>
" Do commit
nnoremap <silent>cc :Git commit<CR>
" Do push
nnoremap <leader>gp :Git push<CR>
" Do pull
nnoremap <leader>gl :Git pull<CR>

" Resolve merge conflicts
nnoremap <leader>mc :Gdiffsplit!<CR>
nnoremap <leader>gm :Gdiffsplit!<CR>
nnoremap <leader>m2 :diffget //2<CR>
nnoremap <leader>m3 :diffget //3<CR>

" Show Commits
nnoremap <leader>gc :Commits!<CR>
" Show Buffer Commits
nnoremap <leader>gx :BCommits!<CR>

" Show History
nnoremap <silent>HH :Gclog<CR>
" Show File History
nnoremap <silent>HF :0Gclog!<CR>

" Git diff previous vs the current version
" With <!> left to right, and focus on current
" TIP: Therefore close with <C-W><C-O>, not :diffoff
nmap <leader>d :Gvdiffsplit! HEAD<CR>
" always open diffs vertical
set diffopt+=vertical

" Show file from master branch when on another branch
nmap <leader>gbm :Gedit master:%<CR>
" Custom{{{

" Amend aliases
command! GCN :Git commit -v --no-edit --amend
command! GCAN :Git commit -v -a --no-edit --amend
command! GCE :Git commit --amend --edit

" Alias for old habit
command! GP :Git push

" Push set upstream
command! GPSUP :!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD 2>/dev/null)
" }}}
" }}}

" fzf-checkout{{{

nnoremap <leader>gb :GBranches<CR>
" }}}
