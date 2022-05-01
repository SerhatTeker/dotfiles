" https://neovim.io/doc/user/filetype.html#new-filetype
" C. If your file type can be detected by the file name or extension.

" my filetype file
if exists("did_load_filetypes")
    finish
endif

" filetype syntax {{{

function DetectGoHtmlTmpl()
    if expand('%:e') == "html" && search("{{") != 0
        setfiletype gohtmltmpl
    endif
endfunction

augroup filetypedetect
    " toml
    au BufNewFile,BufReadPost *.toml setfiletype toml
    " yaml
    au BufNewFile,BufReadPost *.{yaml,yml} setfiletype yaml
    " service, systemd
    au BufNewFile,BufReadPost *.service setfiletype systemd
    " gohtmltmpl
    au BufRead,BufNewFile *.html call DetectGoHtmlTmpl()
augroup END
" }}}
