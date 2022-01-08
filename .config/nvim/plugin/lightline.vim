" " Lightline {{{

" if g:status_bar_choice == "lightline"
"     augroup LoadLightline
"         autocmd!
"         autocmd BufEnter * call plug#load('lightline.vim') | autocmd! LoadLightline
"         autocmd BufEnter * call plug#load('lightline-bufferline') | autocmd! LoadLightline
"     augroup END

"     " Show bufferline
"     " https://github.com/mengelbrecht/lightline-bufferline#faq
"     set showtabline=2

"     " Tmuxline
"     let g:tmuxline_powerline_separators = 0

"     " Vars
"     let g:lightline#bufferline#show_number  = 0
"     let g:lightline#bufferline#shorten_path = 1
"     let g:lightline#bufferline#unnamed      = '[No Name]'

"     " Customizaton {{{

"     let g:lightline                     = {}
"     let g:lightline.tabline             = {'left': [['buffers']], 'right': [['close']]}
"     let g:lightline.component_expand    = {'buffers': 'lightline#bufferline#buffers'}
"     let g:lightline.component_type      = {'buffers': 'tabsel'}
"     let g:lightline.component_function  = {'gitbranch': 'FugitiveHead', 'venv': 'virtualenv#statusline'}

"     " remove parcent
"     " add gitbranch
"     " add python venv
"     let g:lightline.active = {
"         \ 'left': [ [ 'mode', 'paste' ],
"         \           [ 'readonly', 'filename', 'modified' ],
"         \           [ 'gitbranch', 'venv', 'readonly' ] ],
"         \ 'right': [ [ 'lineinfo' ],
"         \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }

"     " default
"     let g:lightline.inactive = {
"         \ 'left': [ [ 'filename' ] ],
"         \ 'right': [ [ 'lineinfo' ] ] }
"     " }}}
" endif
" " }}}

" Lightline {{{

" Show bufferline
" https://github.com/mengelbrecht/lightline-bufferline#faq
set showtabline=2

" Tmuxline
let g:tmuxline_powerline_separators = 0

" Vars
let g:lightline#bufferline#show_number  = 0
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#unnamed      = '[No Name]'

" Customizaton {{{

let g:lightline                     = {}
let g:lightline.tabline             = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand    = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type      = {'buffers': 'tabsel'}
let g:lightline.component_function  = {'gitbranch': 'FugitiveHead', 'venv': 'virtualenv#statusline'}

" remove parcent
" add gitbranch
" add python venv
let g:lightline.active = {
    \ 'left': [ [ 'mode', 'paste' ],
    \           [ 'readonly', 'filename', 'modified' ],
    \           [ 'gitbranch', 'venv', 'readonly' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }

" default
let g:lightline.inactive = {
    \ 'left': [ [ 'filename' ] ],
    \ 'right': [ [ 'lineinfo' ] ] }

if exists(":Tmuxline")
    :Tmuxline lightline
endif
" }}}
" }}}
