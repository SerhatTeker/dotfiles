" CtrlSF {{{2

" Substitute the word under the cursor.
" &	Keep the flags from the previous substitute.
" c	Prompt to confirm each substitution.
" e	Do not report errors.
" g	Replace all occurrences in the line.
" i	Case-insensitive matching.
" I	Case-sensitive matching.
" n	Report the number of matches, do not actually substitute.
nmap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" shows the preview window automatically while moving from match to match in the results pane
let g:ctrlsf_auto_preview = 1

" mappings {{{3

" In CtrlSF window:
" Enter, o, double-click - Open corresponding file of current line in the window which CtrlSF is launched from.
" <C-O> - Like Enter but open file in a horizontal split window.
" t - Like Enter but open file in a new tab.
" p - Like Enter but open file in a preview window.
" P - Like Enter but open file in a preview window and switch focus to it.
" O - Like Enter but always leave CtrlSF window opening.
" T - Like t but focus CtrlSF window instead of new opened tab.
" M - Switch result window between normal view and compact view.
" q - Quit CtrlSF window.
" <C-J> - Move cursor to next match.
" <C-K> - Move cursor to previous match.
" <C-C> - Stop a background searching process.

" let g:ctrlsf_mapping = {
"     \ "popen": "<C-LeftMouse>"
"     \ }

nmap     <leader>f <Plug>CtrlSFPrompt
vmap     <leader>f <Plug>CtrlSFVwordPath
nmap     <leader>F <Plug>CtrlSFCwordPath
" vmap     <C-F>F <Plug>CtrlSFVwordExec
" nmap     <C-F>p <Plug>CtrlSFPwordPath

nnoremap <leader>o :CtrlSFOpen<CR>
nnoremap <leader>t :CtrlSFToggle<CR>
inoremap <leader>t <Esc>:CtrlSFToggle<CR>
" }}}3

" commands {{{3

" <Plug>CtrlSFPrompt
" Input :CtrlSF in command line for you, just a handy shortcut.

" <Plug>CtrlSFVwordPath
" Input :CtrlSF foo in command line where foo is the current visual selected
" word, waiting for further input.

" <Plug>CtrlSFVwordExec
" Like <Plug>CtrlSFVwordPath, but execute it immediately.

" <Plug>CtrlSFCwordPath
" Input :CtrlSF foo in command line where foo is word under the cursor.

" <Plug>CtrlSFCCwordPath
" Like <Plug>CtrlSFCwordPath, but also add word boundary around searching word.

" <Plug>CtrlSFPwordPath
" Input :CtrlSF foo in command line where foo is the last search pattern of vim.

" }}}3
" }}}2