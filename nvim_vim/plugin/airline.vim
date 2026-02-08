" powerline {{{

let g:airline_powerline_fonts = 0
" Handle powerline fallback if powerline can't be installed on host
" https://vi.stackexchange.com/a/3363/38903
" }}}

" extensions {{{

" Show errors or warnings in the statusline
let g:airline#extensions#ale#enabled = 0
let g:airline#extensions#branch#enabled = 1

" obsession - continuously updated session
let g:airline#extensions#obsession#enabled = 0
let g:airline#extensions#obsession#indicator_text = '$'

" show buffers at top
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" gutentag airline
let g:airline#extensions#gutentags#enabled = 1

" coc <https://github.com/neoclide/coc.nvim>
" enable/disable coc integration
let g:airline#extensions#coc#enabled = 0
" change error symbol:
let airline#extensions#coc#error_symbol = 'E:'
" change warning symbol:
let airline#extensions#coc#warning_symbol = 'W:'
" enable/disable coc status display
let g:airline#extensions#coc#show_coc_status = 1

" git-branch
let g:airline#extensions#branch#enabled = 1

" git-hunk
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']

" Disable airline error and warnings, :h airline-default
" let g:airline#extensions#default#layout = [
"             \ [ 'a', 'b', 'c' ],
"             \ [ 'x', 'y', 'z' ],
"             \ ]
" }}}

" AirlineInit {{{

function! AirlineInit()
    " Z Info{{{

    " Default Z Info
    " https://github.com/vim-airline/vim-airline/blob/a294f0cb7e847219f67c2a55d5fb400b7c93d4af/autoload/airline/init.vim#L217
    let spc = g:airline_symbols.space
    " let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%p%%'.spc, 'linenr', 'maxlinenr', ':%v'])
    "
    " Simple Z info : line:column
      let g:airline_section_z = airline#section#create(['%l', ':%c'])               " No Percentage
      " let g:airline_section_z = airline#section#create(['%p%%'.spc, '%l', ':%c'])   " Percentage at the start
      " let g:airline_section_z = airline#section#create(['%l', ':%c ', '%p%%'.spc])  " Percentage at the end
    " }}}

    " Custom Y info : fileencoding|fileformat
    let g:airline_section_y = airline#section#create(['%{&ff}', ' | %{&fenc}'])

    :AirlineRefresh
endfun

" calling from ChangeBackground() in backgroundTheme.vim
" autocmd VimEnter * call AirlineInit()
" }}}
