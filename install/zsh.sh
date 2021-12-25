#!/usr/bin/env bash
# ----------------------------------------------------------------------------#
#                      _           _        _ _       _
#                     (_)_ __  ___| |_ __ _| | |  ___| |__
#                     | | '_ \/ __| __/ _` | | | / __| '_ \
#                     | | | | \__ \ || (_| | | |_\__ \ | | |
#                     |_|_| |_|___/\__\__,_|_|_(_)___/_| |_|
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Install and customize zsh
# Warning : WIP
# ----------------------------------------------------------------------------#
#
# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# shellcheck source=scripts/common.sh
source "${ROOT}/install/common.sh"

DOTFILES="${HOME}/dotfiles"
SYSBAK="${HOME}/system-bak"

# Create ZDOTDIR
mkdir ${HOME}/.zsh
# Export main environment variables for ZSH
export ZMAIN="${HOME}/.zsh"
export ZDOTDIR=${ZMAIN}
export ZSH="${HOME}/.zsh/.oh-my-zsh"

default-shell() {
    sudo sh -c "echo $(which zsh) >> /etc/shells" && chsh -s $(which zsh)
}

oh-my-zsh() {
    wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    ZSH="$HOME/.zsh/.oh-my-zsh" sh install.sh
    rm install.sh
}

# install missing plugins
plugins() {
    ZSH_CUSTOM="${ZSH}/custom"
    # zsh-syntax-highlighting custom plugin
    # https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    # zsh-autosuggestions
    # https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

set-zdotdir() {
    # Set global ZDOTDIR
    # Hacky ugly way to fix tmux behavior
    echo "export ZDOTDIR=\"${HOME}/.zsh\"" | sudo tee -a /etc/zsh/zshenv
}

# create soft links
link-configs() {
    ln -s ${DOTFILES}/zsh/.zshrc ${ZMAIN}/.zhsrc
    ln -s ${DOTFILES}/zsh/.zlogin ${ZMAIN}/.zlogin
    ln -s ${DOTFILES}/zsh/plugins ${ZMAIN}/plugins
    ln -s ${DOTFILES}/zsh/.fzf.zsh ${ZMAIN}/.fzf.zsh
    ln -s ${SYSBAK}/zsh/.private.zsh ${ZMAIN}/.zsh.private
}

main() {
    oh-my-zsh
    plugins
    set-zdotdir
    link-configs
}

main

exit 0
