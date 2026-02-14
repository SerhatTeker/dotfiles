" FZF {{{2

" Settings {{{3

" https://github.com/junegunn/fzf/blob/master/README-VIM.md#examples
" Default fzf layout
" - Popup window (center of the screen)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

" Commands {{{4

" Default Rg
" Don't show filenames in Rg
" https://sidneyliebrand.io/blog/how-fzf-and-ripgrep-improved-my-workflow#finding-content-in-specific-files
command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --hidden --follow --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:40%')
    \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
    \   <bang>0)

" RgRaw
" command! -bang -nargs=* RgRaw call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".<q-args>, 1, <bang>0)
command! -bang -nargs=* RG
    \ call fzf#vim#grep(
    \   'rg --column --line-number --hidden --follow --ignore-case --no-heading --color=always '.<q-args>, 1,
    \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:40%'),
    \   <bang>0)

" https://github.com/junegunn/fzf.vim#example-advanced-ripgrep-integration
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, a:query)
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RGAd call RipgrepFzf(<q-args>, <bang>0)

" AllFiles
" Add an Files variation AllFiles that ignores .gitignore files
command! -bang -nargs=? -complete=dir AllFiles
    \ call fzf#run(fzf#wrap(
    \ 'allfiles',
    \ fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }),
    \ <bang>0))
" }}}4
" }}}3

" key bindings {{{3

" This is the default extra key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit',
            \}

" Cannot use below since it conflict with CamelCaseMotion
" map <leader>b :Buffers<CR>
map B :Buffers<CR>
map <leader>l :Lines<CR>
map <C-p> :<C-u>Files<CR>
map <leader><C-p> :<C-u>AllFiles<CR>
map <C-f> :<C-u>Rg!<CR>
" }}}3

" History {{{3

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" }}}3

" Defaults {{{3

" includes hidden files
" configured already globally in ~/.zshrc
" if executable('ag')
" 	let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
" endif
" }}}3
" }}}2
