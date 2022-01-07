export ZDOTDIR="$HOME/.zsh"

# Unique path dirs
typeset -U path

# ----------------------------------------------------------------------------#
# BIN {{{1
# ----------------------------------------------------------------------------#

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    path+=("$HOME/bin")
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    path+=("$HOME/.local/bin")
fi

# Node modules global
if [ -d "$HOME/.local/bin" ] ; then
    path+=("$HOME/.node_modules/bin")
fi

# Rust
if [ -f "$HOME/.cargo/env" ] ; then
    . "$HOME/.cargo/env"
fi

# Homebrew
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # TODO: Implement
    :
fi
HOMEBREW_NO_ENV_HINTS=1
# ----------------------------------------------------------------------------#
# }}}1
# ----------------------------------------------------------------------------#

# ----------------------------------------------------------------------------#
# ENV {{{1
# ----------------------------------------------------------------------------#

# Dotfiles {{{

export XDG_CONFIG_HOME=${HOME}/.config

# NeoVim
export MYNVIMRC=$HOME/dotfiles/vim/.nvimrc
# export MYNVIMRC=$HOME/.nvimrc

# Bat
export BAT_CONFIG_PATH=${XDG_CONFIG_HOME}/bat/bat.conf

# Ripgrep
export RIPGREP_CONFIG_PATH=${XDG_CONFIG_HOME}/rg/.ripgreprc

# httpie
export HTTPIE_CONFIG_DIR=${XDG_CONFIG_HOME}/httpie

# zsh
ZSH_CUSTOM_HIGHLIGHT="TRUE"

# tmux
# no need for tmux >= 3.1
# export TMUX_DIR=${HOME}/.config/tmux
# export TMUX_CONFIG=${HOME}/.config/tmux/tmux.conf
# }}}

# pass - password-store {{{

# https://git.zx2c4.com/password-store/about/
PASSWORD_STORE_ENABLE_EXTENSIONS=true
# }}}

# IaC {{{

# Ansible
export ANSIBLE_CONFIG=${XDG_CONFIG_HOME}/ansible/ansible.cfg
# }}}

# Python {{{2

export PYTHON_VERSION=3.8
export PYTHON="python${PYTHON_VERSION}"

# Install libs in virtualenv
export PIP_REQUIRE_VIRTUALENV=true

# Use ipdb instead of pdb
export PYTHONBREAKPOINT=ipdb.set_trace
# }}}2

# Containers {{{2

# Docker
# Enabling BuildKit in builds
export DOCKER_BUILDKIT=1

# kind
KINDCONFIG=$HOME/.kube/kind.yaml
# }}}2

# Log {{{

LOG_FILE=/tmp/output.log
# }}}

# Colors {{{2

export COLOR_BLACK="\e[0;30m"
export COLOR_BLUE="\e[0;34m"
export COLOR_GREEN="\e[0;32m"
export COLOR_CYAN="\e[0;36m"
export COLOR_PINK="\e[0;35m"
export COLOR_RED="\e[0;31m"
export COLOR_PURPLE="\e[0;35m"
export COLOR_BROWN="\e[0;33m"
export COLOR_LIGHTGRAY="\e[0;37m"
export COLOR_DARKGRAY="\e[1;30m"
export COLOR_LIGHTBLUE="\e[1;34m"
export COLOR_LIGHTGREEN="\e[1;32m"
export COLOR_LIGHTCYAN="\e[1;36m"
export COLOR_LIGHTRED="\e[1;31m"
export COLOR_LIGHTPURPLE="\e[1;35m"
export COLOR_YELLOW="\e[1;33m"
export COLOR_WHITE="\e[1;37m"
export COLOR_NONE="\e[0m"
# }}}2
# ----------------------------------------------------------------------------#
# }}}1
# ----------------------------------------------------------------------------#
