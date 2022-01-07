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

# Ask for the administrator password upfront
sudo -v

# TODO: give error if not a sysmlink
# or remove dir after informing in advance
# rm ${XDG_CONFIG_HOME}/zsh
# mkdir -p ${XDG_CONFIG_HOME}/zsh

# Export main environment variables for ZSH
export ZMAIN=${XDG_CONFIG_HOME}/zsh
export ZDOTDIR=${ZMAIN}
export ZSH=${ZMAIN}/.oh-my-zsh


default-shell() {
    # make zsh default shell
    sudo sh -c "echo $(which zsh) >> /etc/shells"
    chsh -s $(which zsh)
}

ioh-my-zsh() {
    rm -rf ${DOTFILES}/.config/zsh/.oh-my-zsh

    wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    ZSH="${ZMAIN}/.oh-my-zsh" sh install.sh
    rm install.sh
}

# install custom plugins
iplugins() {
    ZSH_CUSTOM="${ZSH}/custom"

    # zsh-syntax-highlighting custom plugin
    # https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    # zsh-autosuggestions
    # https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    # cd-gitroot
    # https://github.com/mollifier/cd-gitroot
    git clone https://github.com/mollifier/cd-gitroot.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/cd-gitroot

    # zsh-completions
    # https://github.com/zsh-users/zsh-completions
    git clone https://github.com/zsh-users/zsh-completions
        ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
}

set-zdotdir() {
    # Set global ZDOTDIR
    # Hacky ugly way to fix tmux behavior
    echo "export ZDOTDIR=\"${XDG_CONFIG_HOME}/zsh\"" | sudo tee -a /etc/zsh/zshenv
}

# create soft links
link-configs() {
    ln -s ${DOTFILES}/.config/zsh/ ${XDG_CONFIG_HOME}
    ln -sf ${SYSBAK}/zsh/.private.zsh ${ZMAIN}/.private.zsh
    ln -sf ${PRIVATE}/zsh/.private.zsh ${ZMAIN}/.zsh_history
}

main() {
    link-configs
    ioh-my-zsh
    iplugins
    set-zdotdir
}

main

exit 0
