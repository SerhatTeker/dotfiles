" gitgutter {{{
" A Vim plugin which shows git diff markers in the sign column
" and stages/previews/undoes hunks and partial hunks.

if exists(":GitGutter")
    " disabled by default
    let g:gitgutter_enabled = 0
    " toggle with :GitGutterToggle
    " toggle line highlighting :GitGutterLineHighlightsToggle
    " With Neovim 0.3.2 or higher, toggle highlight line nr :GitGutterLineNrHighlightsToggle.

    " Disable mappings, only use my customs
    let g:gitgutter_map_keys = 0
    nnoremap <leader>gt :GitGutterToggle<CR>
    nmap <leader>gh <Plug>(GitGutterPreviewHunk)

    let g:gitgutter_sign_added = '│'
    let g:gitgutter_sign_modified =  '│'
    let g:gitgutter_sign_removed = '_'

    let g:gitgutter_sign_removed_first_line = '‾'
    " let g:gitgutter_sign_removed_above_and_below = '{'
    let g:gitgutter_sign_modified_removed = '~'

    function! GitStatus()
            let [a,m,r] = GitGutterGetHunkSummary()
            return printf('+%d ~%d -%d', a, m, r)
    endfunction

    set statusline+=%{GitStatus()}
endif
" }}}

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
nnoremap <leader>m2 :diffget //2<CR>
nnoremap <leader>m3 :diffget //3<CR>

" Show Commits
nnoremap <leader>gc :Commits!<CR>
" Show Buffer Commits
nnoremap <leader>gbc :BCommits!<CR>

" Show History
nnoremap <silent>HH :Gclog<CR>
" Show File History
nnoremap <silent>HF :0Gclog!<CR>

" Git diff current and previous version
" With <!> left to right, and focus on current
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
