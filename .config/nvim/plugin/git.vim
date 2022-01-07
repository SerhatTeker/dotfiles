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

" vim-gutentags {{{

" How To Generate Ctags Include Python site-packages
" https://github.com/ludovicchabant/vim-gutentags/issues/179
let g:gutentags_file_list_command = {
 \ 'markers': {
     \ '.pythontags': '~/dotfiles/ctags/python_file_lister.py',
     \ },
 \ }

" Below script/solution comes from:
" https://github.com/ludovicchabant/vim-gutentags/issues/178#issuecomment-575693926
" Other related issues:
" https://github.com/ludovicchabant/vim-gutentags/issues/167
" https://github.com/ludovicchabant/vim-gutentags/issues/168
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root  = [
    \ 'package.json',
    \ '.git',
    \  '.hg',
    \ '.svn',
    \ ]
let g:gutentags_cache_dir = expand('~/.cache/nvim/gutentags')
let g:gutentags_exclude_filetypes = [
    \ 'gitcommit',
    \ 'gitconfig',
    \ 'gitrebase',
    \ 'gitsendemail',
    \ 'git',
    \ ]
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]

let g:gutentags_ctags_exclude = [
    \  '*.git', '*.svn', '*.hg',
    \  'cache', 'build', 'dist', 'bin', 'node_modules', 'bower_components',
    \  '*-lock.json',  '*.lock',
    \  '*.min.*',
    \  '*.bak',
    \  '*.zip',
    \  '*.pyc',
    \  '*.class',
    \  '*.sln',
    \  '*.csproj', '*.csproj.user',
    \  '*.tmp',
    \  '*.cache',
    \  '*.vscode', 'Session.vim',
    \  '*.pdb',
    \  '*.exe', '*.dll', '*.bin',
    \  '*.mp3', '*.ogg', '*.flac',
    \  '*.swp', '*.swo',
    \  '.DS_Store', '*.plist',
    \  '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png', '*.svg',
    \  '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
    \  '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx', '*.xls',
    \  '*.md',
    \ ]

" Expanded Exclude
" https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/
" }}}
