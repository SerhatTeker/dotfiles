" Tmuxline {{{

" https://github.com/edkolev/tmuxline.vim#custom-preset
let g:tmuxline_preset = {
            \'a'    : '#S',
            \'b'    : '#(whoami)',
            \'c'    : '#W',
            \'win'  : '#I #W',
            \'cwin' : '#I #W',
            \'x'    : '%R',
            \'y'    : ['w%U:d0%w', '%d-%m-%y'],
            \'z'    : '#h',
            \}

" separators {{{
" https://github.com/edkolev/tmuxline.vim#separators

" let g:tmuxline_powerline_separators = 0

" Fine-tune the separators
let g:tmuxline_separators = {
            \ 'left' : '',
            \ 'left_alt': '|',
            \ 'right' : '',
            \ 'right_alt' : '|',
            \ 'space' : ' ',
            \ }
" }}}
" }}}
