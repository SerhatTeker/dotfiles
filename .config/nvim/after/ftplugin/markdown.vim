" indentation {{{
setlocal 	expandtab
setlocal 	tabstop=2
setlocal	softtabstop=2
setlocal 	shiftwidth=2
setlocal 	textwidth=80		" wrap texts 80chars
setlocal	nocursorline
setlocal	foldenable
" setlocal	spell			" spell check
" }}}

" vim-markdown {{{

let g:vim_markdown_conceal = 0

" fenced-in languages
" if you have many, or maybe super-specific, languages and syntaxes you
" commonly use in your markdown you can specify them in your vimrc to be
" interpreted as such
let g:markdown_fenced_languages = [
            \ 'python',
            \ 'go',
            \ 'javascript',
            \ 'sh',
			\ 'yaml',
            \ 'javascript',
            \ 'html',
            \ 'vim',
            \ 'json',
            \ 'bash=sh'
            \ ]

" bookmark hihglight
let g:book_mark_hi = "on"
" }}}

" bullets.vim {{{

" use it's mappings
let g:bullets_set_mappings = 1
" }}}

" MarkdownPreview {{{

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0
" }}}

" Tabularize {{{
if exists(":Tabularize")
	" Align vnoremap <leader>ss :Tabularize /\S\(' . split(&commentstring, '%s')[0] . '.*\)\@<!\zs\ /l0<CR>
	nnoremap <leader>as :Tabularize /\S\(' . split(&commentstring, '%s')[0] . '.*\)\@<!\zs\ /l0<CR>
	" align with `:`
	nmap <leader>a: :Tabularize /:\zs<CR>
	vmap <leader>a: :tabularize /:\zs<CR>
	" align with `-`
	nmap <leader>a- :Tabularize /-\zs<CR>
	vmap <leader>a- :tabularize /-\zs<CR>
	" align with `=`
	nmap <leader>a= :Tabularize /:\zs<CR>
	vmap <leader>a= :tabularize /:\zs<CR>
	" align end comments
	vnoremap <expr> <Leader>a. ':Tabularize /^\s*\S.*\zs' . split(&commentstring, '%s')[0] . "<CR>"
	nnoremap <expr> <Leader>a. ':Tabularize /^\s*\S.*\zs' . split(&commentstring, '%s')[0] . "<CR>"

	" Additional Patterns
	AddTabularPattern! jo  /:[^-]*\|-.*/l1l0
endif
" }}}

" deoplete {{{

" using for default mappings markdown plugging
" if g:markdown_enable_insert_mode_mappings
inoremap <silent><buffer><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><buffer><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" imap <expr><TAB>
" 	\ neosnippet#expandable_or_jumpable() ? :
" 	\   "\<Plug>(neosnippet_expand_or_jump)" :
" 	\ pumvisible()? "\<C-y>" :
" 	\ <SID>check_back_space() ? "\<TAB>" :
" 	\ deoplete#mappings#manual_complete()
" }}}

" Colors {{{

" Custom syntax colorscheme {{{
" journal
highlight JournalComp ctermfg=154 guifg=#A6E22E
" bookmarks
highlight BookBlue ctermfg=39 guifg=#61AFEF
highlight BookYellow ctermfg=226 guifg=#ffff00
highlight BookGreen ctermfg=114 guifg=#98C379
highlight BookPurple ctermfg=170 guifg=#C678DD
highlight BookUnderline cterm=underline ctermfg=204 guifg=#E06C75
highlight BookOff ctermfg=238 guifg=#3B4048

" Highlight syntax
" journal
match JournalComp /&#9745/
" bookmarks
syntax match BookBlue /<b>/
syntax match BookYellow /<y>/
syntax match BookGreen /<g>/
syntax match BookPurple /<p>/
syntax match BookUnderline /<u>/
" }}}

" Bookmark Highlight {{{
com! BookMarkHi call g:BookMarkHi()
nnoremap <F4> :BookMarkHi<CR>

function! g:BookMarkHi()
	if g:book_mark_hi == "on"
		syntax match BookOff /<b>/
		syntax match BookOff /<y>/
		syntax match BookOff /<g>/
		syntax match BookOff /<p>/
		syntax match BookOff /<u>/
		let g:book_mark_hi = "off"
	else
		syntax match BookBlue /<b>/
		syntax match BookYellow /<y>/
		syntax match BookGreen /<g>/
		syntax match BookPurple /<p>/
		syntax match BookUnderline /<u>/
		let g:book_mark_hi = "on"
	endif
endfunction

" Default one links to Comment
highlight link mkdBlockquote PreProc
" }}}
" }}}

" Functions {{{

" CommentWrap {{{

" Wrap visual selection in an XML comment
vmap <Leader>c <Esc>:call CommentWrap()<CR>

function! CommentWrap()
	normal `>
	if &selection == 'exclusive'
		exe "normal i -->"
	else
		exe "normal a -->"
	endif
	normal `<
	exe "normal i<!-- "
	normal `<
endfunction
" wrap alternative
" vat:s/^\(.*\)$/<!--\1-->/
" }}}

" Toggle spelling {{{

nnoremap <F7> :call ToggleSpell()<CR>

fun! ToggleSpell()
	if &spell == ''
		set spell
	else
		set nospell
	endif
endfun
" }}}
" }}}
