export ZDOTDIR="$HOME/.zsh"

# Unique path dirs
typeset -U path


# BIN {{{1

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    path+=("$HOME/bin")
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    path+=("$HOME/.local/bin")
fi
# }}}1

# ENV {{{1

# pass - password-store
# https://git.zx2c4.com/password-store/about/
PASSWORD_STORE_ENABLE_EXTENSIONS=true

export BAT_CONFIG_PATH="${HOME}/.config/bat.conf"

# Python {{{

export PYTHON_VERSION=3.8
export PYTHON="python${PYTHON_VERSION}"

# Install libs in virtualenv
export PIP_REQUIRE_VIRTUALENV=true

# Use ipdb instead of pdb
export PYTHONBREAKPOINT=ipdb.set_trace
# }}}

# Docker {{{

# Enabling BuildKit in builds
export DOCKER_BUILDKIT=1
# }}}

# kind {{{

KINDCONFIG=$HOME/.kube/kind.yaml
# }}}

# NeoVim Resource {{{2

export MYNVIMRC="$HOME/dotfiles/vim/.nvimrc"
# export MYNVIMRC=$HOME/.nvimrc
# }}}2

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
# }}}1
