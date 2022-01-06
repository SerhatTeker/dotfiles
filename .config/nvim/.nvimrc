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

" Auto Install {{{2

" Automatic Plugin Manager and Plugins installation
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLSso ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYNVIMRC
endif
" }}}2

" PLUGINS {{{2
" ----------------------------------------------------------------------------"
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/plugged')

" Snippets {{{3

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'ervandew/supertab'
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
" }}}3

" Theme {{{3

Plug 'fatih/molokai'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'chriskempson/base16-vim'
Plug 'chuling/vim-equinusocio-material'
Plug 'morhetz/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'flazz/vim-colorschemes'
Plug 'dracula/vim'
" Colors
Plug 'gko/vim-coloresque'
" Tmux
Plug 'edkolev/tmuxline.vim'
" }}}3

" Statusbar {{{3

Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }

" Load plugin on-demand {{{4

" Airline
Plug 'vim-airline/vim-airline', { 'on': [] }
Plug 'vim-airline/vim-airline-themes', { 'on': [] }
" Search mathcup counts and position
Plug 'osyo-manga/vim-anzu', { 'on': [] }

" Lightline
Plug 'itchyny/lightline.vim' , { 'on': [] }
Plug 'mengelbrecht/lightline-bufferline', { 'on': [] }
" }}}4
" }}}3

" Filetype {{{3

" Python {{{4

" syntax
Plug 'SerhatTeker/python-syntax'
" folding
Plug 'tmhedberg/SimpylFold'
" navigation
Plug 'jeetsukumaran/vim-pythonsense'
" Semantic Highliht
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" autoflake: remove unused imports and variables
Plug 'tell-k/vim-autoflake'
" docstring
Plug 'serhatteker/vim-pydocstring', { 'do': 'make install', 'for': 'python' }

" Django
Plug 'tweekmonster/django-plus.vim'
" }}}4

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Yaml
Plug 'pedrohdz/vim-yaml-folds'
Plug 'andrewstuart/vim-kubernetes'

" Markdown {{{4

" default plugin
Plug 'plasticboy/vim-markdown'
" Plug 'plasticboy/vim-markdown', { 'on': [], 'for': []  }
" Plug 'serhatteker/vim-markdown-default'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" bullets
Plug 'dkarter/bullets.vim'
" }}}4

" rst
" Plug 'gu-fan/riv.vim'
" Plug 'gu-fan/InstantRst'
" Plug 'gu-fan/rhythm.css'

Plug 'Rykka/riv.vim'
Plug 'Rykka/InstantRst'

" Terraform
Plug 'hashivim/vim-terraform'
" }}}3

" LSP/CodeComplete/Linter {{{3

Plug 'dense-analysis/ale'

" Code Completion {{{

" Use deoplete for go, for the rest coc.vim
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'antoinemadec/coc-fzf'

" vim-go needs deoplete for realtime omnifunc completion
Plug 'Shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins', 'for': 'go' }
" NOTE: PlugUpdate may not work, in a *.go file call <UpdateRemotePlugins> manually after
" }}}
" }}}

" Syntax {{{3

" vim-polyglot
" https://github.com/sheerun/vim-polyglot#troubleshooting
" Please declare this variable before polyglot is loaded (at the top of .vimrc)
let g:polyglot_disabled = [
            \'markdown',
            \'python',
            \]

Plug 'sheerun/vim-polyglot'
" Plug 'vim-syntastic/syntastic'
" 3}}}

" Git {{{3

Plug 'itchyny/vim-gitbranch'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'	" status info in columns
" }}}3

" motions {{{3

Plug 'bkad/CamelCaseMotion'
" }}}

" Others {{{3
Plug 'godlygeek/tabular'
Plug 'editorconfig/editorconfig-vim'
"" Pair
" Disabled.
" Plug 'SerhatTeker/auto-pairs'
Plug 'jiangmiao/auto-pairs'     " insert mode auto-completion for quotes, parens, brackets, etc
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" Needed for 'vim-surround'
Plug 'tpope/vim-repeat'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/rainbow_parentheses.vim'
" Auto close tags
" Plug 'tpope/vim-endwise'
" Indentline
Plug 'Yggdroot/indentLine'
" }}}3

" Session {{{3

" continuously updated session files
Plug 'tpope/vim-obsession'
" }}}3

" icons {{{3

" Has to be last according to docs
" Plug 'ryanoasis/vim-devicons'
" }}}3

" Vim Wiki {{{3
Plug 'vimwiki/vimwiki'
" }}}3

" Minimal Center {{{3

Plug 'jmckiern/vim-venter'
" Zen Mode
Plug 'junegunn/goyo.vim'
" }}}3

" ctags {{{3
Plug 'ludovicchabant/vim-gutentags'
Plug 'preservim/tagbar'
" }}}3

call plug#end()
" }}}2

" Auto Install on Startup {{{2
" Automatically install missing plugins on startup
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
" set rnu				            " set relative numbers
set ttimeoutlen=100		        " esc delay time
" folding
set nofoldenable                " no fold when opening a file
set foldmethod=marker           " manual fold with '{...}'
" }}}2

" MYNVIMRC {{{2

augroup nvimrc
    " auto source .vimrc after save
    " autocmd! bufwritepost $MYNVIMRC source $MYNVIMRC
    autocmd! BufWritePost ~/dotfiles/.config/nvim/init.vim source % | echom "Reloaded $NVIMRC"
    " FIXME: use $MYNVIMRC instead of hardcoded path
    autocmd! BufWritePost ~/dotfiles/.config/nvim/.nvimrc source % | echom "Reloaded $NVIMRC"
    autocmd! BufWritePost ~/.nvimrc source % | echom "Reloaded $NVIMRC"
    " autocmd! BufWritePost ~/dotfiles/vim/.nvimrc source % | echom "Reloaded $NVIMRC" | redraw

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

" Statusbar {{{2

" Use airline or lightline
" Default one is airline
" Uncomment below to use lightline
" let g:status_bar = "lightline"

let g:status_bar_choice = get(g:, 'status_bar', "airline")

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

" filetype syntax {{{2

" toml
au BufNewFile,BufReadPost *.toml set syntax=toml

" yaml
au BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" service, systemd
au BufNewFile,BufReadPost *.service set syntax=systemd
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

" Jump to next error with Ctrl-n and previous error with Ctrl-b. Close the
" quickfix window with <leader>a
nnoremap <C-q> :copen<CR>
nnoremap <C-q> :copen<CR>


" Toggle {{{3

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <leader>q :call ToggleQuickFix()<CR>
" }}}3
" }}}2

" Run {{{

" Execute the line in VISUAL MODE
vnoremap <F10> :<c-u>exe join(getline("'<","'>"),'<bar>')<cr>
nnoremap <F10> :execute getline(".")<CR>

" Save and run File according to it's filetype
augroup RunFile
    autocmd!
    autocmd FileType python nnoremap <buffer><silent><C-S-F10> :w<CR> :! python3 %<CR>
    autocmd FileType sh nnoremap <buffer><silent><C-S-F10> :w<CR> :! "%:p"<CR>
    autocmd FileType c nnoremap <buffer><silent><C-S-F10> :w<CR> :!clear; gcc %; ./a.out<CR>
    autocmd FileType cpp  nnoremap <buffer><silent><C-S-F10> :w<CR> :!clear; g++ %; ./a.out<CR>
    autocmd FileType ruby nnoremap <buffer><silent><C-S-F10> :w<CR> :!clear; ruby %<CR>
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
if exists(":Tabularize")
    " Align
    vnoremap <leader>ss :Tabularize /\S\(' . split(&commentstring, '%s')[0] . '.*\)\@<!\zs\ /l0<CR>
    nnoremap <leader>ss :Tabularize /\S\(' . split(&commentstring, '%s')[0] . '.*\)\@<!\zs\ /l0<CR>
    " align with `:`
    nmap <leader>a: :Tabularize /:\zs<CR>
    vmap <leader>a: :tabularize /:\zs<CR>
    " align with `-`
    nmap <leader>a- :Tabularize /-<CR>
    vmap <leader>a- :tabularize /-<CR>
    " align with `=`
    nmap <leader>a= :Tabularize /:\zs<CR>
    vmap <leader>a= :tabularize /:\zs<CR>
    " align end comments
    vnoremap <expr> <Leader>a. ':Tabularize /^\s*\S.*\zs' . split(&commentstring, '%s')[0] . "<CR>"
    nnoremap <expr> <Leader>a. ':Tabularize /^\s*\S.*\zs' . split(&commentstring, '%s')[0] . "<CR>"
endif

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv
" }}}

" Add behaviours {{{

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

" fugitive {{{

" Git status
nnoremap <silent>ss :20G<CR>
" Git commit
nnoremap <silent>cc :Gcommit<CR>
" History
nnoremap <silent>HH :Gclog<CR>
" File History
nnoremap <silent>HF :0Gclog!<CR>
" Amend aliases
command! GCN :Git commit -v --no-edit --amend
command! GCAN :Git commit -v -a --no-edit --amend

" Git diff {{{

" Git diff current and previous version
nmap <leader>d :Gvdiffsplit HEAD<CR>
" always open diffs vertical
set diffopt+=vertical
" }}}

" Git push{{{

" Push set upstream
command! GPSUP :!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD 2>/dev/null)
" Not using
function! s:GitCurrentBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null")
endfunction

" Custom GPush
" don't like default silent :Gpush
command! GP :Git push -v
nnoremap <leader>pp :GP<CR>
" }}}
" }}}

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

" Diff {{{2

" :DiffPreSave
com! DiffPreSave call s:DiffPreSaved()

" see changes in the current buffer before save.
" NOTE: use gitgutter instead.
function! s:DiffPreSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
" }}}2

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

augroup MarkdownFiles
    autocmd!
    " define markdown file extensions
    autocmd BufNewFile,BufRead *.{markdown,mdown,mkd,mkdn,mdwn,md}  setf markdown
augroup END
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

" NERDtree {{{

" some usefull commands to remember {{{

" r Refresh NERDTREE
" m modify in TREE
" B Bookmarks
" }}}

" NERDTree Settings {{{

" show hiddens
let NERDTreeShowHidden=1

" Automatically close NerdTree when you open a file
" let NERDTreeQuitOnOpen = 1

" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" Disable that old “Press ? for help”.
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Ignore
let NERDTreeIgnore = [
            \ '\.pyc$',
            \ '^__pycache__$',
            \ '^.mypy_cache$',
            \ '^.pytest_cache$',
            \ '^.hypothesis$',
            \ '^htmlcov$',
            \ '\.retry$',
            \'^node_modules$',
            \]

" show bookmarkds
" let NERDTreeShowBookmarks=1

" To make sure vim does not open files and other buffers on NerdTree window
" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
" }}}

" NERDTree Mappings {{{
nmap <C-t> :NERDTreeToggle<CR>

" Directly open NerdTree on the file you’re editing
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
" }}}
" }}}

" Undo Tree {{{

nnoremap <F5> :UndotreeToggle<cr>
" }}}

" UltiSnips {{{

" let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsEditSplit = "vertical"
" custom Snippets
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" mapping <Control-Space>
let g:UltiSnipsExpandTrigger="<C-space>"
let g:UltiSnipsJumpForwardTrigger="<C-space>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" alternative settings
" let g:UltiSnipsExpandTrigger = "<c-space>"
" let g:UltiSnipsJumpForwardTrigger = "<c-space>"
" let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
" let g:UltiSnipsEnableSnipMate = 0

" }}}

" Deoplete.vim {{{
" Using it for only go

" let g:python3_host_prog = '/usr/bin/python3'
let g:deoplete#enable_at_startup = 1
" let g:deoplete#on_insert_enter = 1
" let g:deoplete#file#enable_buffer_path=1
" let g:deoplete#auto_complete = v:true
" let g:deoplete#auto_complete_popup = "auto"

augroup deopleteGo
    autocmd!
    autocmd FileType go call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
    autocmd FileType go call deoplete#custom#source('ale', 'rank', 999)
augroup END

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" <CR>: close popup
" https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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

nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
nmap     <C-F>F <Plug>CtrlSFCwordPath
" vmap     <C-F>F <Plug>CtrlSFVwordExec
" nmap     <C-F>p <Plug>CtrlSFPwordPath

nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
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

" auto-pair {{{


" Change defaults {{{

" Defaults
" au Filetype * let b:AutoPairs={'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
" Change defaults
au Filetype * let b:AutoPairs={'(':')', '[':']', '{':'}'}
" }}}

" Define Custom AutoPairs {{{

" Markdown
" No Need. Using snippet
" au Filetype markdown let b:AutoPairs = AutoPairsDefine({'{{<' : ' >}}'})
" }}}

" Toggle Autopairs disabled due to conflict {{{

let g:AutoPairsShortcutToggle = ''
let g:AutoPairsUseInsertedCount = 1
let g:AutoPairsDelRepeatedPairs = 1
" Map <space> to insert a space after the opening character and before the closing one
let g:AutoPairsMapSpace = 0
" }}}
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

" Vim Wiki {{{

let g:vimwiki_list = [{'path': '~/wisdom/',
                  \ 'syntax': 'markdown', 'ext': '.md'}]

let g:vimwiki_global_ext = 0

" disable all mappings
let g:vimwiki_key_mappings = { 'all_maps': 0, }

nmap <leader>L <Plug>VimwikiFollowLink
" }}}

" goyo {{{

let g:goyo_width = 120
" }}}

" vim-gutentags {{{

" How To Generate Ctags Include Python site-packages
" https://github.com/ludovicchabant/vim-gutentags/issues/179
let g:gutentags_file_list_command = {
 \ 'markers': {
     \ '.pythontags': '~/dotfiles/ctags/python_file_lister.py',
     \ },
 \ }

" Below script/solution comes from:
" https://github.com/ludovicchabant/vim-gutentags/issues/178#issuecomment-575693926
" Other related issues:
" https://github.com/ludovicchabant/vim-gutentags/issues/167
" https://github.com/ludovicchabant/vim-gutentags/issues/168
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root  = ['package.json', '.git', '.hg', '.svn']
let g:gutentags_cache_dir = expand('~/.gutentags_cache')
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = ['--tag-relative=yes', '--fields=+ailmnS']
let g:gutentags_ctags_exclude = [
    \  '*.git', '*.svn', '*.hg',
    \  'cache', 'build', 'dist', 'bin', 'node_modules', 'bower_components',
    \  '*-lock.json',  '*.lock',
    \  '*.min.*',
    \  '*.bak',
    \  '*.zip',
    \  '*.pyc',
    \  '*.class',
    \  '*.sln',
    \  '*.csproj', '*.csproj.user',
    \  '*.tmp',
    \  '*.cache',
    \  '*.vscode', 'Session.vim',
    \  '*.pdb',
    \  '*.exe', '*.dll', '*.bin',
    \  '*.mp3', '*.ogg', '*.flac',
    \  '*.swp', '*.swo',
    \  '.DS_Store', '*.plist',
    \  '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png', '*.svg',
    \  '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
    \  '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx', '*.xls',
    \  '*.md',
\]
" }}}

" Airline {{{

if g:status_bar_choice == "airline"
    augroup LoadAirline
        autocmd!
        autocmd BufEnter * call plug#load("vim-airline") | autocmd! LoadAirline
        autocmd BufEnter * call plug#load("vim-airline-themes") | autocmd! LoadAirline
        autocmd BufEnter * call plug#load("vim-anzu") | autocmd! LoadAirline
    augroup END

    let g:airline_powerline_fonts = 1

    " extensions {{{

    " Show errors or warnings in the statusline
    let g:airline#extensions#ale#enabled = 1
    let g:airline#extensions#branch#enabled = 1

    " Python virtual env
    let g:airline#extensions#virtualenv#enabled = 1

    " obsession - continuously updated session
    let g:airline#extensions#obsession#enabled = 1
    let g:airline#extensions#obsession#indicator_text = '$'

    " show buffers at top
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_min_count = 2
    let g:airline#extensions#tabline#formatter = 'unique_tail'

    " gutentag airline
    let g:airline#extensions#gutentags#enabled = 1
    " }}}

    " AirlineInit {{{

    function! AirlineInit()
        " Z Info{{{

        " Default Z Info
        " https://github.com/vim-airline/vim-airline/blob/a294f0cb7e847219f67c2a55d5fb400b7c93d4af/autoload/airline/init.vim#L217
        " let spc = g:airline_symbols.space
        " let g:airline_section_z = airline#section#create(['windowswap', 'obsession', '%p%%'.spc, 'linenr', 'maxlinenr', ':%v'])
        "
        " Simple Z info : line:column
        let g:airline_section_z = airline#section#create(['%l', ':%c'])
        " Custom Y info : fileencoding|fileformat
        let g:airline_section_y = airline#section#create(['%{&fenc}', '|%{&ff}'])
        " }}}
        :AirlineRefresh
    endfun

    autocmd VimEnter * call AirlineInit()
    " }}}
endif
" }}}

" Lightline {{{

if g:status_bar_choice == "lightline"
    augroup LoadLightline
        autocmd!
        autocmd BufEnter * call plug#load('lightline.vim') | autocmd! LoadLightline
        autocmd BufEnter * call plug#load('lightline-bufferline') | autocmd! LoadLightline
    augroup END

    " Show bufferline
    " https://github.com/mengelbrecht/lightline-bufferline#faq
    set showtabline=2

    " Tmuxline
    let g:tmuxline_powerline_separators = 0

    " Vars
    let g:lightline#bufferline#show_number  = 0
    let g:lightline#bufferline#shorten_path = 1
    let g:lightline#bufferline#unnamed      = '[No Name]'

    " Customizaton {{{

    let g:lightline                     = {}
    let g:lightline.tabline             = {'left': [['buffers']], 'right': [['close']]}
    let g:lightline.component_expand    = {'buffers': 'lightline#bufferline#buffers'}
    let g:lightline.component_type      = {'buffers': 'tabsel'}
    let g:lightline.component_function  = {'gitbranch': 'FugitiveHead', 'venv': 'virtualenv#statusline'}

    " remove parcent
    " add gitbranch
    " add python venv
    let g:lightline.active = {
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'readonly', 'filename', 'modified' ],
        \           [ 'gitbranch', 'venv', 'readonly' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }

    " default
    let g:lightline.inactive = {
        \ 'left': [ [ 'filename' ] ],
        \ 'right': [ [ 'lineinfo' ] ] }
    " }}}
endif
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

" gitgutter {{{
" A Vim plugin which shows git diff markers in the sign column
" and stages/previews/undoes hunks and partial hunks.

" disabled by default
let g:gitgutter_enabled = 0
" toggle with :GitGutterToggle
" toggle line highlighting :GitGutterLineHighlightsToggle
" With Neovim 0.3.2 or higher, toggle highlight line nr :GitGutterLineNrHighlightsToggle.

" Disable mappings, only use my customs
let g:gitgutter_map_keys = 0
nnoremap <leader>tg :GitGutterToggle<CR>
nmap <leader>hp <Plug>(GitGutterPreviewHunk)
" }}}

" autoflake {{{
" Removes unused imports and unused variables as reported by pyflakes
" https://github.com/myint/autoflake
" https://github.com/tell-k/vim-autoflake

" Remove mapping
let g:no_autoflake_maps=1

" Default <F9>
" no need: using in AleFixCustom()
autocmd FileType python map <buffer> <leader><F3> :call Autoflake()<CR>

" Remove all unused imports, whether or not they are from the standard library
let g:autoflake_remove_all_unused_imports=1
let g:autoflake_remove_unused_variables=0
let g:autoflake_disable_show_diff=0
" }}}

" vim-pydocstring {{{

let g:pydocstring_doq_path = '~/.local/bin/doq'
let g:pydocstring_formatter = 'google'
nmap <silent> <C-_> <Plug>(pydocstring)
" }}}
" ----------------------------------------------------------------------------"
"	}}}
" ----------------------------------------------------------------------------"
