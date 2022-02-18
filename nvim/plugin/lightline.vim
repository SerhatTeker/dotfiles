" " Lightline {{{

" Lightline
" Plug 'itchyny/lightline.vim'
" Plug 'mengelbrecht/lightline-bufferline'
" Plug 'shinchu/lightline-gruvbox.vim'

" " Show bufferline
" " https://github.com/mengelbrecht/lightline-bufferline#faq
" set showtabline=2

" " Tmuxline
" let g:tmuxline_powerline_separators = 0

" " Vars
" let g:lightline#bufferline#show_number  = 0
" let g:lightline#bufferline#shorten_path = 1
" let g:lightline#bufferline#unnamed      = '[No Name]'

" " Customizaton {{{

" let g:lightline                     = {}
" let g:lightline.tabline             = {'left': [['buffers']], 'right': [['close']]}
" let g:lightline.component_expand    = {'buffers': 'lightline#bufferline#buffers'}
" let g:lightline.component_type      = {'buffers': 'tabsel'}
" let g:lightline.component_function  = {'gitbranch': 'FugitiveHead', 'venv': 'virtualenv#statusline'}

" " remove parcent
" " add gitbranch
" " add python venv
" let g:lightline.active = {
"     \ 'left': [ [ 'mode', 'paste' ],
"     \           [ 'gitbranch', 'modified' ],
"     \           [ 'readonly', 'relativepath', 'venv' ] ],
"     \ 'right': [ [ 'lineinfo' ],
"     \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }

" " default
" let g:lightline.inactive = {
"     \ 'left': [ [ 'filename' ] ],
"     \ 'right': [ [ 'lineinfo' ] ] }
" " }}}
" " }}}
