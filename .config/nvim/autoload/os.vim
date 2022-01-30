function! GetOS()
    if has("unix")
        if has("mac")
            return "mac"
        else
            return "linux"
        endif
    endif
    if has("win32") || has("win64")
        return "win"
    endif
endfunction

function! IsMac()
    if has("unix")
        if has("mac")
            return 1
        endif
    endif
endfunction


" let os=GetRunningOS()
