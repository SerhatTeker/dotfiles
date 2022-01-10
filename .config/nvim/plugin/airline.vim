" powerline {{{
" Handle Powerline Fallback
" https://vi.stackexchange.com/a/3363/38903

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
" }}}

" extensions {{{

" Show errors or warnings in the statusline
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#enabled = 1

" Python virtual env
let g:airline#extensions#virtualenv#enabled = 1

" obsession - continuously updated session
let g:airline#extensions#obsession#enabled = 1
let g:airline#extensions#obsession#indicator_text = '$'

" show buffers at top
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#formatter = 'unique_tail'

" gutentag airline
let g:airline#extensions#gutentags#enabled = 1
" }}}

" AirlineInit {{{

function! AirlineInit()
    " Z Info{{{

    " Default Z Info
    " https://github.com/vim-airline/vim-airline/blob/a294f0cb7e847219f67c2a55d5fb400b7c93d4af/autoload/airline/init.vim#L217
    " let spc = g:airline_symbols.space
    " let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%p%%'.spc, 'linenr', 'maxlinenr', ':%v'])
    "
    " Simple Z info : line:column
    let g:airline_section_z = airline#section#create(['%l', ':%c'])
    " Custom Y info : fileencoding|fileformat
    let g:airline_section_y = airline#section#create(['%{&fenc}', '|%{&ff}'])
    " }}}
    :AirlineRefresh
endfun

autocmd VimEnter * call AirlineInit()
" }}}
