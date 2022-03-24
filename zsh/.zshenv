# ----------------------------------------------------------------------------#
#                                   _
#                           _______| |__   ___ _ ____   __
#                          |_  / __| '_ \ / _ \ '_ \ \ / /
#                         _ / /\__ \ | | |  __/ | | \ V /
#                        (_)___|___/_| |_|\___|_| |_|\_/
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
# License: https://github.com/SerhatTeker/dotfiles/LICENSE
#
# ----------------------------------------------------------------------------#

# Disable zsh default compinit since oh-my-zsh will compinit
# Starting Issue
# https://github.com/ohmyzsh/ohmyzsh/issues/7332
# Solution
# https://github.com/ohmyzsh/ohmyzsh/issues/7332#issuecomment-491595390
# https://github.com/ohmyzsh/ohmyzsh/issues/7332#issuecomment-593308026
skip_global_compinit=1

# https://wiki.archlinux.org/index.php/XDG_Base_Directory_support
# User directories
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_LIB_HOME="${HOME}/.local/lib"

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# ----------------------------------------------------------------------------#
# BIN {{{1
# ----------------------------------------------------------------------------#

# Unique path dirs
typeset -U path

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
    path+=("${HOME}/bin")
fi

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/.local/bin" ] ; then
    path+=("${HOME}/.local/bin")
fi

# Node modules global
if [ -d "${HOME}/.local/bin" ] ; then
    path+=("${HOME}/.node_modules/bin")
fi

# Rust
if [ -f "${HOME}/.cargo/env" ] ; then
    source "${HOME}/.cargo/env"
fi

# Python
if [[ "${OSTYPE}" == "darwin"* ]]; then
    path+=("${HOME}/Library/Python/3.8/bin")
fi

# Golang
if [ -e "/usr/local/go" ] ; then
    path+=("${HOME}/go/bin")    # $GOPATH
    path+=("/usr/local/go/bin")
fi

# Homebrew {{{

if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
    if [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
elif [[ "${OSTYPE}" == "darwin"* ]]; then
    # Warning: /usr/bin occurs before $HOME/.homebrew/bin in your PATH. This
    # means that system-provided programs will be used instead of thoseprov
    if [ -d "$HOME/.homebrew/bin" ]; then
        eval "$(${HOME}/.homebrew/bin/brew shellenv)"
    fi
fi

export HOMEBREW_NO_ENV_HINTS=1
# }}}

# ----------------------------------------------------------------------------#
# }}}1
# ----------------------------------------------------------------------------#

# ----------------------------------------------------------------------------#
# ENV {{{1
# ----------------------------------------------------------------------------#

# Dotfiles {{{

# NeoVim
# TODO: Move it to $XDG_CONFIG_HOME
export MYNVIMRC="$HOME/dotfiles/nvim/.nvimrc"
# Bat
export BAT_CONFIG_PATH="${XDG_CONFIG_HOME}/bat/bat.conf"
# Ripgrep
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/rg/.ripgreprc"
# httpie
export HTTPIE_CONFIG_DIR="${XDG_CONFIG_HOME}/httpie"
# zsh
export ZSH_CUSTOM_HIGHLIGHT="TRUE"

# tmux
# no need for tmux >= 3.1
# export TMUX_DIR=${HOME}/.config/tmux
# export TMUX_CONFIG=${HOME}/.config/tmux/tmux.conf
# }}}

# pass - password-store {{{

# https://git.zx2c4.com/password-store/about/
export PASSWORD_STORE_ENABLE_EXTENSIONS=true
# }}}

# IaC {{{

# Ansible
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible/ansible.cfg"
# }}}

# Python {{{2

# TODO: Add sysmlink python3 -> ~/.local/bin/python3.8 on MacOS
export PYTHON_VERSION=3.8
export PYTHON="python${PYTHON_VERSION}"

# Install libs in virtualenv
export PIP_REQUIRE_VIRTUALENV=true

# TODO: Add exists check
# Use pudb instead of pdb
export PYTHONBREAKPOINT=pudb.set_trace
# Alternative: use ipdb instead of pdb
# export PYTHONBREAKPOINT=ipdb.set_trace

export IPYTHONDIR="${XDG_CONFIG_HOME}/.ipython"
# }}}2

# Golang {{{

export GOPATH="${HOME}/go"
export GOBIN="${GOPATH}/bin"
# }}}

# Containers {{{2

# Docker
# Enabling BuildKit in builds
export DOCKER_BUILDKIT=1

# kind
export KINDCONFIG="${XDG_CONFIG_HOME}/kube/kind.yaml"
# }}}2

# Log {{{

export LOG_FILE="/tmp/output.log"
# }}}

# Colors {{{2

export COLOR_NONE="\e[0m"
export COLOR_WHITE="\e[1;37m"
export COLOR_RED="\e[0;31m"
export COLOR_BLUE="\e[0;34m"
export COLOR_GREEN="\e[0;32m"
export COLOR_YELLOW="\e[1;33m"
export COLOR_BROWN="\e[0;33m"
export COLOR_PINK="\e[0;35m"
export COLOR_CYAN="\e[0;36m"
export COLOR_PURPLE="\e[0;35m"
export COLOR_BLACK="\e[0;30m"
export COLOR_LIGHTGRAY="\e[0;37m"
export COLOR_DARKGRAY="\e[1;30m"
export COLOR_LIGHTBLUE="\e[1;34m"
export COLOR_LIGHTGREEN="\e[1;32m"
export COLOR_LIGHTCYAN="\e[1;36m"
export COLOR_LIGHTRED="\e[1;31m"
export COLOR_LIGHTPURPLE="\e[1;35m"
# }}}2
# ----------------------------------------------------------------------------#
# }}}1
# ----------------------------------------------------------------------------#
