" https://github.com/numEricL/nerdtree-live-preview/blob/main/plugin/NERDTreePreview.vim
"
" # NERDTreePreview
" Extends [NERDTree](https://github.com/preservim/nerdtree) with a live preview of
" files as you navigate the tree.

" ## Dependencies and Requirements
" * [NERDTree](https://github.com/preservim/nerdtree)
" * A shell with `file -ib`, used for excluding binary files from previews.
" * Vim version 8.0 (although mostly functional with 7.04)

" ## Installation
" Use a vim plugin manager or add NERDTreePreview.vim to ~/.vim/plugin

" ## Usage
" NERDTreePreview displays a preview of non-binary files in the last active
" window. Upon quitting (hotkey q) or refocusing to a different window, the
" preview window is restored to the original buffer. Preview windows are
" non-modifiable, to edit you must open the file with the NERDTree default
" mappings.

" ## Known Limitations
" * Currently requires NERDTreeQuitOnOpen=1 to be set
" * Default NERDTree mappings must be used
" * Using :q to exit the NERDTree window does not clear the preview, use q instead
" * Opening vim on a directory (e.g. `vim .`) does not load NERDTreePreview correctly

" Enable if NERDTree enabled
if !exists(':NERDTreeToggle')
    let g:NERDTreePreview_Enable = 0
else
    if !exists('g:NERDTreePreview_Enable')
        let g:NERDTreePreview_Enable = 1
    endif
endif

let g:NERDTreePreview_line_count_limit = 10000

augroup NERDTreePreview
    autocmd VimEnter * if (g:NERDTreePreview_Enable) | call NERDTreePreview_Enable()
augroup END

function NERDTreePreview_Enable() abort
    call NERDTreeAddKeyMap({
                \ 'key':           '<c-j>',
                \ 'callback':      'NERDTreePreview_j',
                \ 'quickhelpText': 'preview',
                \ 'override': '1',
                \ })
    call NERDTreeAddKeyMap({
                \ 'key':           '<c-k>',
                \ 'callback':      'NERDTreePreview_k',
                \ 'quickhelpText': 'preview',
                \ 'override': '1',
                \ })
    " call NERDTreeAddKeyMap({
    "             \ 'key': '<cr>',
    "             \ 'callback': 'NERDTreePreview_o',
    "             \ 'quickhelpText': 'same as o custom',
    "             \ 'override': '1',
    "             \ 'scope': 'FileNode',
    "             \ })
    " call NERDTreeAddKeyMap({
    "             \ 'key': 'o',
    "             \ 'callback': 'NERDTreePreview_o',
    "             \ 'quickhelpText': 'o custom',
    "             \ 'override': '1',
    "             \ 'scope': 'FileNode',
    "             \ })
    " call NERDTreeAddKeyMap({
    "             \ 'key': 't',
    "             \ 'callback': 'NERDTreePreview_t',
    "             \ 'quickhelpText': 't custom',
    "             \ 'override': '1',
    "             \ 'scope': 'FileNode',
    "             \ })
    " call NERDTreeAddKeyMap({
    "             \ 'key': 'T',
    "             \ 'callback': 'NERDTreePreview_T',
    "             \ 'quickhelpText': 'T custom',
    "             \ 'override': '1',
    "             \ 'scope': 'FileNode',
    "             \ })
    " call NERDTreeAddKeyMap({
    "             \ 'key': 'i',
    "             \ 'callback': 'NERDTreePreview_i',
    "             \ 'quickhelpText': 'i custom',
    "             \ 'override': '1',
    "             \ 'scope': 'FileNode',
    "             \ })
    " call NERDTreeAddKeyMap({
    "             \ 'key': 'gi',
    "             \ 'callback': 'NERDTreePreview_gi',
    "             \ 'quickhelpText': 'gi custom',
    "             \ 'override': '1',
    "             \ 'scope': 'FileNode',
    "             \ })
    " call NERDTreeAddKeyMap({
    "             \ 'key': 's',
    "             \ 'callback': 'NERDTreePreview_s',
    "             \ 'quickhelpText': 's custom',
    "             \ 'override': '1',
    "             \ 'scope': 'FileNode',
    "             \ })
    " call NERDTreeAddKeyMap({
    "             \ 'key': 'gs',
    "             \ 'callback': 'NERDTreePreview_gs',
    "             \ 'quickhelpText': 'gs custom',
    "             \ 'override': '1',
    "             \ 'scope': 'FileNode',
    "             \ })
    " call NERDTreeAddKeyMap({
    "             \ 'key': 'q',
    "             \ 'callback': 'NERDTreePreview_q',
    "             \ 'quickhelpText': '...',
    "             \ 'override': '1',
    "             \ })
endfunction

function NERDTreePreview_j() abort
    normal! j
    call s:SetPreviewWindow()
    call s:Show()
endfunction

function NERDTreePreview_k() abort
    normal! k
    call s:SetPreviewWindow()
    call s:Show()
endfunction

function NERDTreePreview_o(...) abort
    let l:filepath = s:GetCurrentNode()
    call s:SetPreviewWindow()
    call s:Quit()
    execute 'edit +setlocal\ modifiable '.l:filepath
endfunction

function NERDTreePreview_t(...) abort
    let l:filepath = s:GetCurrentNode()
    call s:SetPreviewWindow()
    call s:Quit()
    execute '$tabnew +setlocal\ modifiable '.l:filepath
endfunction

function NERDTreePreview_T(...) abort
    let l:nerdtree_win = s:Win_getid(winnr())
    let l:filepath = s:GetCurrentNode()
    call s:SetPreviewWindow()
    execute '$tabnew +setlocal\ modifiable|setlocal\ noreadonly '.l:filepath
    call s:Win_gotoid(l:nerdtree_win)
endfunction

function NERDTreePreview_i(...) abort
    let l:filepath = s:GetCurrentNode()
    call s:SetPreviewWindow()
    call s:Quit()
    execute 'split +setlocal\ modifiable '.l:filepath
endfunction

function NERDTreePreview_gi(...) abort
    let l:filepath = s:GetCurrentNode()
    call s:SetPreviewWindow()
    call s:RestorePreviewWindow()
    execute 'split +setlocal\ modifiable|setlocal\ noreadonly '.l:filepath
    call s:SetPreviewWindow()
endfunction

function NERDTreePreview_s(...) abort
    let l:filepath = s:GetCurrentNode()
    call s:SetPreviewWindow()
    call s:Quit()
    execute 'vsplit +setlocal\ modifiable '.l:filepath
endfunction

function NERDTreePreview_gs(...) abort
    let l:filepath = s:GetCurrentNode()
    call s:SetPreviewWindow()
    call s:RestorePreviewWindow()
    execute 'vsplit +setlocal\ modifiable|setlocal\ noreadonly '.l:filepath
    call s:SetPreviewWindow()
endfunction

function NERDTreePreview_q(...) abort
    call s:Quit()
endfunction

function s:GetCurrentNode() abort
    let l:filepath = ""
    let l:file_obj = g:NERDTreeFileNode.GetSelected()

    if l:file_obj != {}
        let l:filepath = l:file_obj.path.str()
    endif
    return l:filepath
endfunction

function s:SetPreviewWindow() abort
    let l:preview_changed = !s:IsSamePreviewWindow()
    if exists('b:NERDTreePreview_preview_win') && l:preview_changed
        call NERDTreeFocus()
        wincmd p
        let l:new_preview_win = s:Win_getid(winnr())
        call s:RestorePreviewWindow()
        call s:Win_gotoid(l:new_preview_win)
    endif
    if !exists('b:NERDTreePreview_preview_win') || l:preview_changed
        call NERDTreeFocus()
        wincmd p
        let l:preview_win = s:Win_getid(winnr())
        let l:original_buf = bufnr('%')
        call NERDTreeFocus()
        let b:NERDTreePreview_preview_win = l:preview_win
        let b:NERDTreePreview_original_buf = l:original_buf
    endif
endfunction

function s:RestorePreviewWindow() abort
    call NERDTreeFocus()
    if exists('b:NERDTreePreview_preview_win')
        let l:original_buf = b:NERDTreePreview_original_buf
        call s:Win_gotoid(b:NERDTreePreview_preview_win)
        execute 'buffer '.l:original_buf
    endif
endfunction

let s:unlisted_buffers = {}
function s:Show() abort
    let l:file_obj = g:NERDTreeFileNode.GetSelected()
    if l:file_obj == {}
        return
    endif
    let l:filename = l:file_obj.path.str()
    if winbufnr(b:NERDTreePreview_preview_win) == bufnr(l:filename)
        return
    endif

    if filereadable(l:filename) && !s:Skip(l:filename)
        call NERDTreeFocus()
        call s:Win_gotoid(b:NERDTreePreview_preview_win)
        if buflisted(l:filename)
            execute 'edit '.l:filename
        else
            let l:shortmess_revert = &shortmess
            set shortmess+=A
            execute 'edit +setlocal\ nobuflisted|setlocal\ nomodifiable|setlocal\ readonly '.l:filename
            let &shortmess = l:shortmess_revert
            let s:unlisted_buffers[bufnr('%')] = ''
        endif
        call NERDTreeFocus()
    endif
endfunction

function s:IsSamePreviewWindow() abort
    call NERDTreeFocus()
    let l:result = 1
    if exists('b:NERDTreePreview_preview_win')
        let l:preview_win = b:NERDTreePreview_preview_win
        wincmd p
        let l:result = s:Win_getid(winnr()) == l:preview_win
    endif
    call NERDTreeFocus()
    return l:result
endfunction

function s:Quit() abort
    call s:RestorePreviewWindow()
    call NERDTreeFocus()
    if exists('b:NERDTreePreview_preview_win')
        unlet b:NERDTreePreview_preview_win
        unlet b:NERDTreePreview_original_buf
    endif
    silent! NERDTreeClose
    call s:DeleteUnlistedBuffers()
endfunction

function s:DeleteUnlistedBuffers() abort
    for l:num in keys(s:unlisted_buffers)
        silent execute l:num.'bwipeout'
    endfor
    let s:unlisted_buffers = {}
endfunction

function s:Skip(file) abort
    let line_count = system( 'wc -l '.shellescape(a:file).' | awk '.shellescape('{print $1}') )
    if line_count > g:NERDTreePreview_line_count_limit
        return 1
    endif

    if system('file -ib '.shellescape(a:file)) =~# 'binary'
        return 1
    endif

    return 0
endfunction

function s:Win_getid(nr) abort
    if v:version >= 800
        return win_getid(a:nr)
    else
        return a:nr
    endif
endfunction

function s:Win_gotoid(id) abort
    if v:version >= 800
        return win_gotoid(a:id)
    else
        if 0 < a:id && a:id <= winnr('$')
            execute a:id."wincmd w"
            return 1
        else
            return 0
        endif
    endif
endfunction
