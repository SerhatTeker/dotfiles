#                                       _
#                               _______| |__  _ __ ___
#                              |_  / __| '_ \| '__/ __|
#                             _ / /\__ \ | | | | | (__
#                            (_)___|___/_| |_|_|  \___|
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles


# SETUP {{{1
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# }}}1

# THEME {{{1

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# alternatives {{{

# ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="avit"
# ZSH_THEME="powerlevel9k/powerlevel9k"

# simple - bash like
# ZSH_THEME="gallois"
# ZSH_THEME="simple"
# }}}

# Base16 Shell
# Optional
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
	[ -s "$BASE16_SHELL/profile_helper.sh" ] && \
		eval "$("$BASE16_SHELL/profile_helper.sh")"
# }}}1

# SETTINGS-1 {{{1

# Defaults {{{

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# UPDATE

# TIP
# Manual Update
# $ upgrade_oh_my_zsh

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=14

# Uncomment auto-update without prompting
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
# }}}

# prompt settings {{{
_fix_cursor() {
	# change cursor color
	echo -ne '\e]12;orange\a'
	# alternative: xterm 214 or 220
}
precmd_functions+=(_fix_cursor)

# }}}

# Editor {{{2

# Preferred editor for local and remote sessions
# use nvim
# if not exists use vim
if [ -f $(which nvim) ]; then
	export EDITOR='nvim'
else
	if [ -f $(which vim) ]; then
		export EDITOR='vim'
	fi
fi

# SSH different editor choice
# if [[ -n $SSH_CONNECTION ]]; then
# 	export EDITOR='vim'
# fi
# }}}2


# python venv {{{2

# chpwd is a zsh hook, wich is executed after change directory
# More info: http://zsh.sourceforge.net/Doc/Release/Functions.html
# function chpwd() {
#   if [ -z "$VIRTUAL_ENV" ]; then
# 	# If a virtualenv with name of .venv, load it.
# 	if [ -d .venv/ ]; then
# 		source .venv/bin/activate
# 	fi
#   fi
# }
# }}}2

# }}}1

# Environment Varibles {{{1

# Python
# Use ipdb instead of pdb
export PYTHONBREAKPOINT=ipdb.set_trace
# }}}1

# PLUGINS {{{1

# Enabled Plugins {{{2

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	vi-mode
	# dotenv
	python
	django
	docker
	docker-compose
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
# }}}2

# Config Plugins {{{2

# Dotenv {{{3

# Disable confirmation message
# "dotenv: source '.env' file in the directory?"
ZSH_DOTENV_PROMPT=false
# }}}3

# Zlong Alert {{{3

# __Disabled: it is so annoying__
# A plugin to alert you when a long-running command has finished
# source ~/dotfiles/zsh/plugins/zlong_alert.zsh

# zlong_duration=120
# zlong_ignore_cmds="vim nvim vi vs ssh libreoffice firefox chrome thunderbird 'python manage.py'"
# }}}3

# auto suggestion {{{3
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# }}}3

# zsh-highlight {{{3

# below settings from this url
# https://framagit.org/phineas0fog/dotfiles/blob/ \
# 51385cb0d9ff4b244ecd0293a49c189b1352c1c4/custom/plugins/ \
# zsh-syntax-highlighting-filetypes/zsh-syntax-highlighting-filetypes.zsh
ZSH_HIGHLIGHT_STYLES+=(
	default			               'fg=248'
	unknown-token		           'fg=196,bold,bg=234'
	reserved-word		           'fg=197,bold'
	alias			               'fg=197,bold'
	builtin			               'fg=107,bold'
	function		               'fg=85,bold'
	command			               'fg=166,bold'
	hashed-command		           'fg=70'
	path			               'fg=30'
	globbing		               'fg=170,bold'
	history-expansion	           'fg=blue'
	single-hyphen-option	       'fg=244'
	double-hyphen-option	       'fg=244'
	back-quoted-argument	       'fg=220,bold'
	single-quoted-argument	       'fg=137'
	double-quoted-argument	       'fg=137'
	dollar-double-quoted-argument  'fg=148'
	back-double-quoted-argument    'fg=172,bold'
	assign			               'fg=240,bold'
)

# Declare the variable
typeset -A ZSH_HIGHLIGHT_PATTERNS

# To have commands starting with `rm -rf` in red:
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
# }}}3

# agnoster {{{3

[ -f $HOME/.zsh/.agnoster.zsh ] && source $HOME/.zsh/.agnoster.zsh
# }}}3

# FZF {{{3

[ -f $HOME/.zsh/.fzf.zsh ] && source $HOME/.zsh/.fzf.zsh
# }}}3
# }}}2
# }}}1

# SETTINGS-2 {{{1

# Aliases and Functions {{{2

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
if [ -f $HOME/.aliases ]; then
	. $HOME/.aliases
fi

# Functions definitions
if [ -f $HOME/.functions ]; then
	. $HOME/.functions
fi

# Senstive functions which are not pushed to Github
# It containssome functions, aliases etc...
[ -f $HOME/.zsh/.zsh_private ] && source $HOME/.zsh/.zsh_private
# }}}2

# History {{{2

# !!! Warning !!!
# History settings should be after `source $ZSH/oh-my-zsh.sh`
HISTSIZE=10000000
SAVEHIST=$HISTSIZE

setopt HIST_IGNORE_ALL_DUPS # ignore duplicated commands history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time
setopt SHARE_HISTORY # share command history data
# }}}2
# }}}1
