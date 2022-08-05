"                                    _
"                         _ ____   _(_)_ __ ___  _ __ ___
"                        | '_ \ \ / / | '_ ` _ \| '__/ __|
"                       _| | | \ V /| | | | | | | | | (__
"                      (_)_| |_|\_/ |_|_| |_| |_|_|  \___|
"
" Author: Serhat Teker <serhat.teker@gmail.com>
" Source: https://github.com/SerhatTeker/dotfiles
" License: https://github.com/SerhatTeker/dotfiles/LICENSE
"
" ----------------------------------------------------------------------------"
"	Plugin Manager	{{{1
" ----------------------------------------------------------------------------"

" Auto install {{{2
" Automatic plugin manager and plugins installation
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLSso ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source expand('~/.config/nvim/.nvimrc') " $MYNVIMRC
endif
" }}}2

" PLUGINS {{{2
" ----------------------------------------------------------------------------"
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/plugged')

" -- Lua world --
Plug 'nvim-lua/plenary.nvim'

" Snippets {{{3

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" }}}3

" Finders {{{3

" enables fzf for vim and shell
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim'
" }}}3

" Navigation {{{3

Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'mbbill/undotree'
Plug 'tpope/vim-unimpaired'
Plug 'easymotion/vim-easymotion'                        " motions on speed
Plug 'kshenoy/vim-signature'                            " toggle, display and navigate marks
Plug 'ThePrimeagen/harpoon'                             " Navigate defined main marks/files in workspaces
" }}}3

" Colors|Theme|Icons {{{3

" Themes
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
" Colors
Plug 'gko/vim-coloresque'                               " css/less/sass/html color preview for vim
Plug 'edkolev/tmuxline.vim'                             " Tmux
" Icons
" Plug 'ryanoasis/vim-devicons'                           " file type icons
" }}}3

" Statusbar {{{3

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'osyo-manga/vim-anzu'                              " Search matchup counts and position
" }}}3

" Filetype {{{3

" Python {{{4

Plug 'SerhatTeker/python-syntax'                        " Syntax highliht
" NOTE: Use blueyed fork: https://github.com/numirias/semshi/pull/111
Plug 'blueyed/semshi', { 'branch': 'handle-ColorScheme', 'do': ':UpdateRemotePlugins' } " Semantic syntax highliht
Plug 'tmhedberg/SimpylFold'                             " Folding
Plug 'jeetsukumaran/vim-pythonsense'                    " Navigation
Plug 'tell-k/vim-autoflake'                             " Autoflake: remove unused imports and variables
Plug 'serhatteker/vim-pydocstring', { 'do': 'make install', 'for': 'python'}            " docstring
Plug 'tweekmonster/django-plus.vim'                     " Django
" }}}4

" Golang
if executable('go')
    Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
endif

" Yaml
Plug 'pedrohdz/vim-yaml-folds'
Plug 'andrewstuart/vim-kubernetes'

" Markdown {{{4

" default plugin
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown' }
Plug 'dkarter/bullets.vim'
" }}}4

Plug 'Rykka/riv.vim'
Plug 'Rykka/InstantRst'

" Terraform
Plug 'hashivim/vim-terraform'
" }}}3

" LSP/CodeComplete/Linter {{{3

" CoC
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'antoinemadec/coc-fzf'

" Ale
" NOTE: Ale and Coc: https://github.com/neoclide/coc.nvim/issues/348#issuecomment-810929209
" CoC and Ale together: https://github.com/dense-analysis/ale#faq-coc-nvim
" Plug 'dense-analysis/ale'
" }}}3

" Syntax {{{3

" vim-polyglot
" https://github.com/sheerun/vim-polyglot#troubleshooting
" Please declare this variable before polyglot is loaded (at the top of .vimrc)
let g:polyglot_disabled = [
            \'markdown',
            \'python',
            \]

Plug 'sheerun/vim-polyglot'
" }}}3

" Git {{{3

Plug 'tpope/vim-fugitive'           " A Git wrapper
Plug 'stsewd/fzf-checkout.vim'      " Manage branches and tags with fzf
Plug 'lewis6991/gitsigns.nvim'      " status info in columns
Plug 'sindrets/diffview.nvim'       " Single tabpage interface for all git revs
" }}}3

" Session {{{3

Plug 'tpope/vim-obsession'                              " continuously updated session files

" Activity tracking
" ActivityWatch watcher: https://docs.activitywatch.net/en/latest/watchers.html
if filereadable(expand("~/apps/activitywatch/aw-qt"))
    Plug 'ActivityWatch/aw-watcher-vim'
endif
" }}}3

" Minimal {{{3

" Zen Mode
Plug 'junegunn/goyo.vim'
" Plug 'jmckiern/vim-venter'      " Similar to goyo but keeps statusbar, tabline etc.
" }}}3

" ctags {{{3

Plug 'ludovicchabant/vim-gutentags'
Plug 'preservim/tagbar'
" }}}3

" Others {{{3

Plug 'godlygeek/tabular'                " Align text with : / = |, etc.
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'             " comment stuff out
Plug 'AndrewRadev/splitjoin.vim'        " Switch between single-line and multiline forms of code
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'bkad/CamelCaseMotion'             " Motions
Plug 'jiangmiao/auto-pairs'             " insert mode auto-completion for quotes, parens, brackets, etc
Plug 'tpope/vim-surround'               " Delete/change/add parentheses/quotes/XML-tags/much more
Plug 'tpope/vim-repeat'                 " Needed for 'vim-surround'
Plug 'Yggdroot/indentLine'              " Indentline
" }}}3

call plug#end()
" }}}2

" Auto install on startup {{{2
" Automatically install missing plugins on startup/vimenter
autocmd VimEnter *
            \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \|   PlugInstall --sync | q
            \| endif
" }}}2
" ----------------------------------------------------------------------------"
"	}}}
" ----------------------------------------------------------------------------"


" ----------------------------------------------------------------------------"
"	Settings	{{{1
" ----------------------------------------------------------------------------"
" sets {{{2

syntax on
set nocompatible                " enables us vim specific features
filetype off                    " reset filetype detection first ...
filetype plugin indent on       " ... and enable filetype detection
set ttyfast                     " indicate fast terminal conn for faster redraw
set laststatus=2                " show status line always
set encoding=utf-8              " set default encoding to utf-8
set autoread                    " automatically read changed files
set autoindent                  " enabile autoindent
set backspace=indent,eol,start  " makes backspace key more powerful.
set incsearch                   " shows the match while typing
set hlsearch                    " highlight found searches
set noerrorbells                " no beeps
set number                      " show line numbers
set showcmd                     " show me what i'm typing
set noswapfile                  " don't use swapfile
set nobackup                    " don't create annoying backup files
set splitright                  " vertical windows should be split to right
set splitbelow                  " horizontal windows should split to bottom
set autowrite                   " automatically save before :next, :make etc.
set hidden                      " buffer should still exist if window is closed
set fileformats=unix,dos,mac    " prefer unix over windows over os 9 formats
set noshowmatch                 " do not show matching brackets by flickering
set noshowmode                  " we show the mode with airline or lightline
set ignorecase                  " search case insensitive...
set smartcase                   " ... but not it begins with upper case
set completeopt=menu,menuone    " show popup menu, even if there is one entry
set pumheight=10                " completion window max size
set nocursorcolumn              " do not highlight column (speeds up highlighting)
" set nocursorline              " do not highlight cursor (speeds up highlighting)
set cursorline
set lazyredraw                  " wait to redraw
set rnu				            " set relative numbers
set ttimeoutlen=100		        " esc delay time
" folding
set nofoldenable                " no fold when opening a file
set foldmethod=marker           " manual fold with '{...}'
" }}}2

" custom vars {{{

let g:localShare='$HOME/.local/share/nvim'
let g:dotFiles='$HOME/dotfiles/.config/nvim'
" }}}

" MYNVIMRC {{{2

augroup nvimrc
    " auto source .vimrc after save in files in nvim dot dir
    autocmd! BufWritePost ~/dotfiles/nvim/* source % | echom "Reloaded $NVIMRC"
    autocmd! BufWritePost ~/.config/nvim/.nvimrc source % | echom "Reloaded $NVIMRC"

    " $MYNVIMRC filetype
    autocmd! BufNewFile,BufRead .nvimrc set filetype=vim
augroup END
" }}}

" Copy to Clipboard {{{2

" enable to copy to clipboard for operations like yank, delete, change and put
" http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
if has('unnamedplus')
    set clipboard^=unnamed
    set clipboard^=unnamedplus
endif
" }}}2

" Persistent Undo {{{2

" this enables us to undo files even if you exit vim.
if has('persistent_undo')
    set undofile
    set undodir=~/.local/share/nvim/tmp/undo//
endif
" }}}2

" Preview {{{2

if has('nvim')
    " Preview command results
    set inccommand=nosplit
endif
" }}}

" autoload buffer {{{2

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
            \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
" }}}2

" Auto Split Equally {{{

" Not using for performance
" autocmd VimEnter * wincmd =
" autocmd VimEnter * execute "normal \<C-=>"
" autocmd BufNewFile,BufRead,BufEnter *
" }}}

" tags {{{2

set tags=tags
" }}}2

" indentation {{{2

" spaces instead of tab
" filetype plugin indent on
" " show existing tab with 4 spaces with
" set tabstop=4
" " when indenting with '>', use 4 spaces width
" set shiftwidth=4
" " on pressing tab, insert 4 spaces
" set expandtab

" }}}2

" save {{{2

" restore last cursor position
au BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

" save all if focus lost
" au FocusLost * :wa
" }}}2

" listchars {{{2

" show special chars
set listchars=eol:§,tab:¤›,extends:»,precedes:«,nbsp:‡,trail:-,space:␣
" set listchars=eol:$,extends:»,precedes:«,nbsp:‡,space:␣
" set listchars=eol:¬,,tab:»/,extends:»,precedes:«,nbsp:‡
" }}}2

" legacy Vim settings {{{2
if !has('nvim')
    set ttymouse=xterm2             " indicate terminal type for mouse codes
    set ttyscroll=3                 " speedup scrolling
endif
" }}}2

" gopass {{{2

" https://github.com/gopasspw/gopass/blob/master/docs/setup.md#securing-your-editor
" Diable temporary files outside of the secure working directory when editing
" secrets.
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
" }}}
" ----------------------------------------------------------------------------"
"	}}}1
" ----------------------------------------------------------------------------"


" ----------------------------------------------------------------------------"
"	Mappings	{{{1
" ----------------------------------------------------------------------------"
" Set leader shortcut to a comma ','. By default it's the backslash
let mapleader = ","

" Quickfix {{{2

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <leader>q :call ToggleQuickFix()<CR>
" }}}2

" Run {{{

nnoremap <leader><F10> :execute getline(".")<CR>
" Execute the line in VISUAL MODE
vnoremap <leader><F10> :<c-u>exe join(getline("'<","'>"),'<bar>')<CR>

" Save and run File according to it's filetype
augroup RunFile
    autocmd!
    autocmd FileType python nnoremap <buffer><silent><F10> :w<CR> :! python3 %<CR>
    autocmd FileType sh nnoremap <buffer><silent><F10> :w<CR> :! bash %<CR>
    " Needs chdmod
    " autocmd FileType sh nnoremap <buffer><silent><F10> :w<CR> :!%:p<CR>
    autocmd FileType c nnoremap <buffer><silent><F10> :w<CR> :!clear; gcc %; ./a.out<CR>
    autocmd FileType cpp  nnoremap <buffer><silent><F10> :w<CR> :!clear; g++ %; ./a.out<CR>
    autocmd FileType ruby nnoremap <buffer><silent><F10> :w<CR> :!clear; ruby %<CR>
augroup END
" }}}

" Commands {{{

" Shortcuts for qa
command! Q :qa
command! WQ :wqa
" }}}

" buffers {{{

" buffer navigation
map <S-n> :bn<CR>
map <S-m> :bp<CR>

" alternatives
" nnoremap <C-B>n :bn<CR>
" nnoremap <C-B>p :bp<CR>

" Delete
" default delete
" nnoremap <C-B>d :bd<CR>
" Deleting a buffer without closing the window
nnoremap <C-B>d :BW<CR>
command! BW :bn|:bd#
" Close all buffers but current
nnoremap <C-B>c :BufCurOnly<CR>
" }}}

" Align {{{
"
" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv
" }}}

" Add behaviours {{{

" Shortcut quit
nnoremap Q :x<CR>

" TODO: add up and down for slide the line
noremap <Up> gk
noremap <Down> gj

" Visual linewise up and down by default (and use gj gk to go quicker)
" no visual line
noremap j gj
noremap k gk

" one key stroke less
noremap ; :

" additional <esc> map
imap jk <esc>
imap kj <esc>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
" nnoremap N Nzzzv

" Act like D and C
nnoremap Y y$

" noh - no highlight
map <esc> :noh <CR>
" }}}

" splits {{{

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>
" }}}

" Others {{{

" show whitespaces as chars {{{

" whitespaces trimmed after save
map <F3> :set list! list? <CR>

" Enter automatically into the files directory
" autocmd BufEnter * silent! lcd %:p:h
" }}}

" Paste toggle {{{

set pastetoggle=<F2>
" }}}

" Move lines {{{

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" }}}
" }}}
" ----------------------------------------------------------------------------"
"	}}}
" ----------------------------------------------------------------------------"


" ----------------------------------------------------------------------------"
"	Functions	{{{1
" ----------------------------------------------------------------------------"

" Renumber {{{2
" let i=1 | '<,'> g/\d. /s//\=i.'. '/ | let i=i+1
" vnoremap <f10> :<c-u>exe join(getline("'<","'>"),'<bar>')<cr>
" }}}2

" Handling Whitespaces {{{2

" trim whitespaces auto after save
let g:trim_white_spaces_auto = 1

" trim function
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" check var
if trim_white_spaces_auto == 1
    " run when file saved
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
endif

" map to <F5>
" nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

" Highlight WhitespaceEOL
" highlight NvimInternalError ctermfg=9 ctermbg=9 guifg=Red guibg=Red
" match NvimInternalError /\s\+$/
" }}}2

" Buffers {{{2

" close all buffers except current one
command! BufCurOnly execute '%bdelete|edit#|bdelete#'

" set current buffer syntax to sh
" handy for new bash script file w/0 `sh` extension
command! BashSyntax execute 'set syntax=sh'
" }}}2

" Zettelkasten {{{2

" NewZettel {{{3

" Insert Zettel Note with filename after actual date prefix in ZETTELKASTEN_DIR
let g:zettelkasten = "$ZETTELKASTEN_DIR/"
command! -nargs=1 NewZettel :execute ":e" zettelkasten . strftime("%Y%m%d%H%M") . "_<args>.md"
nnoremap <leader>zn :NewZettel
" 3}}}

" Insert Zettel File Link{{{3

function! HandleFZF(file)
    "let filename = fnameescape(fnamemodify(a:file, ":t"))
    "why only the tail ?  I believe the whole filename must be linked unless everything is flat ...
    " let filename = fnameescape(a:file)
    " let filename_wo_timestamp = fnameescape(fnamemodify(a:file, ":t:s/^[0-9]*-//"))
    " Get filename w/0 extension
    let filename_wo_timestamp = fnameescape(fnamemodify(a:file, ":t:r:s/^[0-9]*-//"))
     " Insert the markdown link to the file in the current buffer
    let mdlink = "[[".filename_wo_timestamp."]]"
    put=mdlink
endfunction

command! -nargs=1 HandleFZF :call HandleFZF(<f-args>)
" inoremap <buffer> <leader>nh <esc>:call fzf#run({'sink': 'HandleFZF'})<CR>
" nnoremap <leader>nh :call fzf#run({'sink': 'HandleFZF'})<CR>
nnoremap <leader>zh :call fzf#run({'sink': 'HandleFZF'})<CR>
inoremap <leader>zh <esc>:call fzf#run({'sink': 'HandleFZF'})<CR>
" 3}}}
"
" Zettel Meta {{{3
" Needed for Hugo meta's .Title|title
function! InsertCurrentFileName()
    let curfilename = fnameescape(expand("%:t"))
    " let curfilename_wo_timestamp = fnameescape(fnamemodify(expand("%"), ":t:s/^[0-9]*-//"))
    " let curfilename_upper = fnameescape(fnamemodify(expand("%"), ':t:s/(^.\|_\a\)'))
    " :substitute(curfilename, '\(^.\|_\a\)', '\u&', 'g')
    " let curfilename_upper = substitute(curfilename, '\(^.\|-\a\)', '\u&', 'g')
    let filename = "\"".curfilename."\""
    put=filename
endfunction

command! InsertCurrentFileName :call InsertCurrentFileName()

" Replace filenames with titles
function! ZettelMeta()
    call InsertCurrentFileName()
    " replace - with space
    :s/-/ /ge
    :s/_/ - /ge
    :s/\.md//ge
    " uppercase the line
    :s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g
endfunction

command! ZettelMeta :call ZettelMeta()
nnoremap <leader>zm :ZettelMeta
" 3}}}

" Open or Create File {{{3

map <leader>gf :e <cfile>.md<cr>
" 3}}}
" 2}}}

" Debug {{{

" Debug highlight group on cursor
" https://stackoverflow.com/a/9464929
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

map <F12> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }}}
" ----------------------------------------------------------------------------"
"	}}}
" ----------------------------------------------------------------------------"


" ----------------------------------------------------------------------------"
"	Pluggins	{{{1
" ----------------------------------------------------------------------------"
" Formatting {{{

" format on save
" augroup fmt
" 	autocmd!
" 	autocmd BufWritePre * undojoin | Neoformat
" augroup END

" run manually
" nnoremap <leader>f :Neoformat<CR>
" }}}

" ftpplugin {{{
" conf files
" Indentation
" au BufNewFile,BufRead *.vimrc,*tmux.conf,*.zshrc,*.zsh,*.zsh-theme,*.functions,*.aliases colorscheme molokai " set filetype=sh
" au BufNewFile,BufRead *.vimrc,*tmux.conf,*.zshrc,*.zsh,*.zsh-theme,*.functions,*.aliases set filetype=sh

" Markdown
" vim-markdown
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_mappings = 0
let g:markdown_enable_conceal = 0
" }}}

" FOLDING {{{

" FOLDING2 {{{

" 0
" autocmd FileType markdown set foldexpr=NestedMarkdownFolds()
" let g:markdown_fold_style = 'nested'    " folding vim-markdown-folding
" let g:markdown_enable_folding = 1     " folding gabrielelana

" TODO: adapt this
" https://vim.fandom.com/wiki/Folding
" augroup vimrc
"     au BufReadPre * setlocal foldmethod=indent
"     au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
" augroup END

" 1
" set foldmethod=indent
" set foldnestmax=10
" set nofoldenable
" set foldlevel=1

" 2
" set foldmethod=syntax
" set foldlevelstart=1
" let javaScript_fold=1         " JavaScript
" let perl_fold=1               " Perl
" let php_folding=1             " PHP
" let r_syntax_folding=1        " R
" let ruby_fold=1               " Ruby
" let sh_fold_enabled=1         " sh
" let vimsyn_folding='af'       " Vim script
" let xml_syntax_folding=1      " XML

" 3 | plasticboy

" let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_style_pythonic = 1

let g:vim_markdown_toml_frontmatter = 1

" }}}

" gabrielelana/vim-markdown
let g:markdown_enable_folding = 1
" }}}

" Undo Tree {{{

nnoremap <F5> :UndotreeToggle<cr>
" }}}

" UltiSnips {{{

" let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsEditSplit = "vertical"
" custom Snippets
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsExpandTrigger="<nop>"
let g:ulti_expand_or_jump_res = 0
function! <SID>ExpandSnippetOrReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"

" }}}

" camelCaseMotion {{{

call camelcasemotion#CreateMotionMappings('<leader>')
" }}}

" indentLine {{{
"
" only works with space indentation

let g:indentLine_enabled = 1
let g:indentLine_fileTypeExclude = ['python', 'markdown', 'help']

" Indent Char
let g:indentLine_char = '|'
" each indent level has a distinct character.
" let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" let g:indentLine_char = '┊'     " Sublime-like

" first level
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_first_char = '|'

" let g:indentLine_setColors = 0
" }}}

" Bullets.vim {{{
let g:bullets_enabled_file_types = [
            \ 'markdown',
            \]
" }}}

" editorconfig {{{

" To ensure that this plugin works well with Tim Pope's fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']
" To avoid loading EditorConfig for any remote files over ssh:
" let g:EditorConfig_exclude_patterns = ['scp://.\*']
" }}}

" vim-pythonsense {{{

" both the stock Vim 8.0+ motions and vim-pythonsense
let g:is_pythonsense_alternate_motion_keymaps = 1
" }}}

" vim-anzu {{{
" Search mathcup counts and position

" clear status
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
" }}}

" Tagbar {{{
" Vim plugin that displays tags in a window, ordered by scope

nmap <F9> :TagbarToggle<CR>
" }}}
" ----------------------------------------------------------------------------"
"	}}}
" ----------------------------------------------------------------------------"
