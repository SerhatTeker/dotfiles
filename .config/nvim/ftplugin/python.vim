" Semshi {{{

"Mark selected nodes (those with the same name and scope as the one under the
"cursor). Set to 2 to highlight the node currently under the cursor, too.
let g:semshi#mark_selected_nodes = 1
" Show a sign in the sign column if a syntax error occurred.
let g:semshi#error_sign = v:true
" Delay in seconds until the syntax error sign is displayed. (A low delay time
" may distract while typing.)
let g:semshi#error_sign_delay = 1.5
" Factor to delay updating of highlights. Updates will be delayed by factor *
" number of lines second
let g:semshi#update_delay_facto = 0.0

" Custom Colors for OneDark Theme
function! SemshiCustomHighlights()
    hi semshiSelf               guifg=#E5C07B
    hi semshiBuiltin            guifg=#56B6C2
    hi semshiSelected           guifg=#1b1b1b guibg=#ABB2BF
    hi semshiParameter          guifg=#D19A66                       " Default Parameter
    hi semshiParameterUnused    guifg=#895829 gui=underline,italic
    " Alternative
    " hi semshiParameter          guifg=#E06C75                     " Parameter Pylance style
    " hi semshiParameterUnused    guifg=#7e1b23 gui=underline,italic
endfunction
autocmd FileType python call SemshiCustomHighlights()
" }}}
