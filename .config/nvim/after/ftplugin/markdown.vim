" Settings {{{l

" indentation
setlocal 	expandtab
setlocal 	tabstop=2
setlocal	softtabstop=2
setlocal 	shiftwidth=2
setlocal 	textwidth=80		" wrap texts 80chars
setlocal	nocursorline
setlocal	foldenable
" setlocal	spell			" spell check
" }}}

" PlugIns {{{
" bookmark hihglight
let g:book_mark_hi = "on"

" bullets.vim
" use it's mappings
let g:bullets_set_mappings = 1

" fenced-in languages
" if you have many, or maybe super-specific, languages and syntaxes you
" commonly use in your markdown you can specify them in your vimrc to be
" interpreted as such
let g:markdown_fenced_languages = ['python', 'go', 'javascript', 'sh',
			\ 'yaml', 'javascript', 'html', 'vim', 'json', 'bash=sh']

" MarkdownPreview {{{2

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
" let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
" let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
" let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
" let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
" let g:mkdp_browser = ''
" }}}2
" }}}

" Mappings {{{

" Align {{{2
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
" }}}2

" deoplete {{{2

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
" }}}2
" }}}

" Colors {{{

" to ensure that Vim uses 256 colors
" https://stackoverflow.com/a/15376154/10802538
setlocal t_Co=256
let rehash256 = 1
let molokai_original = 1

" Colorscheme {{{

" Use default one for now: neodark
" colorscheme solokai

" Airline
" check if the plugin is loaded
" if exists(':AirlineTheme')
" 	:AirlineTheme molokai
" else
" 	let airline_theme = 'molokai'
" endif
" }}}

" Custom syntax colorscheme {{{2
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
" }}}2
" }}}

" Functions {{{
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
