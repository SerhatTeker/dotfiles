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

# XDG directories
# https://wiki.archlinux.org/index.php/XDG_Base_Directory_support
# User directories
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_LIB_HOME="${HOME}/.local/lib"
# Aliases for XDG directories
export XCONFIG="${XDG_CONFIG_HOME}"
export XBIN="${XDG_BIN_HOME}"
export XDATA="${XDG_DATA_HOME}"
export XCACHE="${XDG_CACHE_HOME}"
export XLIB="${XDG_LIB_HOME}"

# Zsh root
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# Disable coredumps for systemd
# https://www.cyberciti.biz/faq/disable-core-dumps-in-linux-with-systemd-sysctl
ulimit -S -c 0

# ----------------------------------------------------------------------------#
# ENV {{{1
# ----------------------------------------------------------------------------#

# Dotfiles {{{

# NeoVim
export MYNVIMRC="${XDG_CONFIG_HOME}/nvim/.nvimrc"
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

export PYTHON_VERSION="3.8"
export PYTHON="python${PYTHON_VERSION}"

# Install libs in virtualenv
export PIP_REQUIRE_VIRTUALENV=true

# https://docs.python.org/3.8/using/cmdline.html?highlight=pythonpycacheprefix#envvar-PYTHONPYCACHEPREFIX
export PYTHONPYCACHEPREFIX="${HOME}/.cache/cpython/"

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

# Node {{{

# Change default ${HOME}/.npmrc userconfig file location
# https://docs.npmjs.com/cli/v8/using-npm/config#userconfig
export npm_config_userconfig="${XDG_CONFIG_HOME}/node/.npmrc"
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

# Lvim {{{

# Needed for tmux session. Setting from ~/.local/bin/lvim already.
# https://github.com/LunarVim/LunarVim/issues/1987#issuecomment-1032563301
export LUNARVIM_RUNTIME_DIR="${XDG_DATA_HOME}/lunarvim"
export LUNARVIM_CONFIG_DIR="${XDG_CONFIG_HOME}/lvim"
export LUNARVIM_CACHE_DIR="${XDG_CACHE_HOME}/lvim"
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

# GPG {{{

export GPG_TTY="$(tty)"
# }}}
# ----------------------------------------------------------------------------#
# }}}1
# ----------------------------------------------------------------------------#

# ----------------------------------------------------------------------------#
# BIN {{{1
# ----------------------------------------------------------------------------#

# Unique path dirs
typeset -U path

# set PATH so it includes user's bin if it exists
if [ -d "${HOME}/bin" ] ; then
    path+=("${HOME}/bin")
fi

# set PATH so it includes user's bin if it exists
if [ -d "${HOME}/.local/bin" ] ; then
    path+=("${HOME}/.local/bin")
fi

# Node npm modules global
if [ -d "${XDG_LIB_HOME}/node/npm" ] ; then
    path+=("${XDG_LIB_HOME}/node/npm")
fi

# Python
if [[ "${OSTYPE}" == "darwin"* ]]; then
    path+=("${HOME}/Library/Python/${PYTHON_VERSION}/bin")
fi

# Golang
[ -d "/usr/local/go/bin" ] && path+=("/usr/local/go/bin")       # linux
[ -d "${HOME}/go/bin" ] && path+=("${HOME}/go/bin")             # $GOPATH

if [[ "${OSTYPE}" == "darwin"* ]]; then
    if command -v go >/dev/null 2>&1; then
        # version changes path
        path+=("$(go env GOROOT)/bin")
    fi
fi

# Rust
export RUSTUP_HOME="${HOME}/rust/.rustup"
export CARGO_HOME="${HOME}/rust/.cargo"

if [ -d "${HOME}/rust/.cargo" ]; then
    source "${HOME}/rust/.cargo/env"
fi

# Homebrew {{{

if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
    if [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
elif [[ "${OSTYPE}" == "darwin"* ]]; then
    if [ -d "$HOME/.homebrew/bin" ]; then
        eval "$(${HOME}/.homebrew/bin/brew shellenv)"
    fi
fi

export HOMEBREW_NO_ENV_HINTS=1
# }}}

# ----------------------------------------------------------------------------#
# }}}1
# ----------------------------------------------------------------------------#
