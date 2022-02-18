#!/usr/bin/env bash
# ----------------------------------------------------------------------------#
#                                   _           _
#                           _______| |__    ___| |__
#                          |_  / __| '_ \  / __| '_ \
#                           / /\__ \ | | |_\__ \ | | |
#                          /___|___/_| |_(_)___/_| |_|
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Install and customize zsh
# ----------------------------------------------------------------------------#


# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# shellcheck source=scripts/common.sh
source "${ROOT}/install/common.sh"

# Export main environment variables for ZSH
export ZMAIN=${XDG_CONFIG_HOME}/zsh
export ZDOTDIR=${ZMAIN}
export ZSH=${ZMAIN}/.oh-my-zsh
DOT_ZSH=${DOTFILES}/zsh    # Alias for dotfiles zsh


__default-shell() {
    # make zsh default shell
    sudo sh -c "echo $(which zsh) >> /etc/shells"
    chsh -s $(which zsh)
}

check_zsh_installed() {
    if hash zsh 2>/dev/null; then
        echo "Configuring zsh"
    else
        echo "Zsh not installed. Install first."
        exit 1
    fi
}

# Create XDG_CONFIG_HOME link
link-xdg() {
    # Linux
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f "${XDG_CONFIG_HOME}/zsh" ] || [ ! -L "${XDG_CONFIG_HOME}/zsh" ];then
            # or remove dir after informing in advance?
            echo "${XDG_CONFIG_HOME}/zsh is not a symlink. Delete it manually."
            exit 1
        else
            unlink "${XDG_CONFIG_HOME}/zsh"
            ln -sf "${DOT_ZSH}" "${XDG_CONFIG_HOME}/zsh"
        fi
    # MacOS
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if [ -f "${XDG_CONFIG_HOME}/zsh" ] && [ ! -L "${XDG_CONFIG_HOME}/zsh" ];then
            echo "${XDG_CONFIG_HOME}/zsh is not a symlink. Delete it manually."
            exit 1
        else
            unlink "${XDG_CONFIG_HOME}/zsh"
            ln -sf "${DOT_ZSH}" "${XDG_CONFIG_HOME}/zsh"
        fi
    # Other
    else
        echo "${OSTYPE} not implemented"
        exit 1
    fi
}

# create personal soft links
link-personal() {
    if [ -f ${SYSBAK}/zsh/.private.zsh ]; then
        ln -sf ${SYSBAK}/zsh/.private.zsh ${ZMAIN}/.private.zsh
    fi

    if [ -f ${PRIVATE}/zsh/.zsh_history ]; then
        ln -sf ${PRIVATE}/zsh/.zsh_history ${ZMAIN}/.zsh_history
    fi
}

# Set ZDOTDIR globally
set-zdotdir() {
    # Set global ZDOTDIR
    # Hacky ugly way to fix tmux behavior
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "export ZDOTDIR=\"\$HOME/.config/zsh\"" | \
            sudo tee -a /etc/zsh/zshenv
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # TODO: Implement
        echo "export ZDOTDIR=\"\$HOME/.config/zsh\"" | \
            sudo tee -a /etc/zshenv
    else
        echo "No install configuration for ${OSTYPE}"
        exit 1
    fi
}

ioh-my-zsh() {
    if [[ -d "${HOME}/dotfiles/zsh/.oh-my-zsh" ]];then
        rm -rf ${DOT_ZSH}/.oh-my-zsh
    fi
    wget \
        https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh \
        -P /tmp
    ZSH="${ZMAIN}/.oh-my-zsh" sh /tmp/install.sh
    # ZSH="${ZMAIN}/.oh-my-zsh" sh /tmp/install.sh > /dev/null 2>&1
}

# TODO: replace/sed ZDOTDIR with XDG_CACHE_HOME in oh-my-zsh.sh
modify-oh-my-zsh() {
    # https://github.com/ohmyzsh/ohmyzsh/blob/4e2f4cdf686fe560cec3ec7072628c4d0f723929/oh-my-zsh.sh#L108
    # ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
    # ZSH_COMPDUMP="${XDG_CACHE_HOME}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
    echo ""
}

# TODO: Fix: not working together with ioh-my-zsh
# Modify install.sh script
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
    git clone https://github.com/zsh-users/zsh-completions \
        ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
}

custom-themes() {
    for theme in "simple" "gallois"
    do
        ln -sf ${DOT_ZSH}/oh-my-zsh/custom/themes/${theme}-custom.zsh-theme \
            ${ZSH}/custom/themes
    done
}


main() {
    # __default-shell
    check_zsh_installed
    link-xdg
    link-personal
    set-zdotdir
    ioh-my-zsh
    iplugins
    custom-themes
}

main
# iplugins
# link-personal

exit 0
