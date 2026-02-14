#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:
# ----------------------------------------------------------------------------#
#                                   _           _
#                           _______| |__    ___| |__
#                          |_  / __| '_ \  / __| '_ \
#                           / /\__ \ | | |_\__ \ | | |
#                          /___|___/_| |_(_)___/_| |_|
#
# Author: Serhat Teker <me@serhatteker.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Install and customize zsh
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=SC1090
source "${ROOT}/install/common.sh"

# Export main environment variables for ZSH
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZSH="${XDG_DATA_HOME}/zsh/.oh-my-zsh"
# Custom directory
ZSH_CUSTOM="${ZSH}/custom"

DOT_ZSH="${DOTFILES}/zsh" # Alias for dotfiles zsh

# Install {{{

install_zsh() {
    # MacOS comes with zsh as default shell, however keep it.
    if ! command_exists zsh; then
        brew install zsh
        info "Zsh installed."
    else
        info "Zsh already installed."
    fi
}

# Set ZDOTDIR globally
set_zdotdir() {
    # Set global ZDOTDIR
    # Hacky ugly way to fix tmux behavior
    # TODO: replace, not append
    echo "export ZDOTDIR=\"\$HOME/.config/zsh\"" |
        sudo tee -a /etc/zshenv

    info "Succesfully set \$ZDOTDIR"
}
# }}}

# Soft Links {{{

# Create XDG_CONFIG_HOME link
link_xdg() {
    force_remove "${DOT_ZSH}" "${XDG_CONFIG_HOME}/zsh"
    info "Zsh dotfiles linked to \$XDG_CONFIG_HOME"
}

# Create personal soft links
link_personal() {
    local hostname="$(hostname)"
    local source_file="${PRIVATE}/${hostname/.*/}/zsh/.private.zsh"

    if [ -f "${source_file}" ]; then
        force_remove "${source_file}" "${ZDOTDIR}/.private.zsh"
        info "Linked personal files"
    else
        warn "${source_file} not exists"
    fi
}
# }}}

# oh-my-zsh {{{

install_oh-my-zsh() {
    msg "Installing .oh-my-zsh"
    # Fresh install: Remove if exists
    [ -d "${ZSH}" ] && rm -rf "${ZSH}"

    wget --no-check-certificate \
        https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh \
        -P /tmp

    #   --unattended: sets both CHSH and RUNZSH to 'no'
    ZSH="${ZSH}" sh /tmp/install.sh --unattended

    # somehow .oh-my-zsh overwrites my .zshrc
    cp "${DOT_ZSH}/.zshrc.main" "${DOT_ZSH}/.zshrc"

    info ".oh-my-zsh installed."
}

# }}}
# }}}

# Customs {{{

# Install custom plugins
custom_plugins() {
    msg "Installing custom plugins"

    # zsh-syntax-highlighting custom plugin
    # https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
    git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
        "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"

    # zsh-autosuggestions
    # https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
    git clone "https://github.com/zsh-users/zsh-autosuggestions" \
        "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"

    # cd-gitroot
    # https://github.com/mollifier/cd-gitroot
    git clone "https://github.com/mollifier/cd-gitroot.git" \
        "${ZSH_CUSTOM}/plugins/cd-gitroot"

    # zsh-completions
    # https://github.com/zsh-users/zsh-completions
    git clone "https://github.com/zsh-users/zsh-completions" \
        "${ZSH_CUSTOM}/plugins/zsh-completions"

    info "Installed custom plugins."
}

# Link custom themes
custom_themes() {
    local themes="${ZSH_CUSTOM}/themes"

    # Clean start
    [ -d "${themes}" ] && rm -rf "${themes}" && mkdir -p "${themes}"

    for file in "${DOT_ZSH}/oh-my-zsh/custom/themes/"*; do
        local filename="$(basename "$file")"
        force_remove "$file" "${themes}/${filename}"
        msg "${themes}/${filename} completed."
    done

	info "Custom themes completed."
}

# Link custom completions
custom_completions() {
    local completions="${ZSH}/completions"

    # Clean start
    [ -d "${completions}" ] && rm -rf "${completions}" && mkdir -p "${completions}"

    for file in "${DOT_ZSH}/oh-my-zsh/completions/"*; do
        local filename="$(basename "$file")"
        force_remove "$file" "${completions}/${filename}"
        msg "${completions}/${filename} completed."
    done

    info "Custom completions completed."
}
# }}}


main() {
    install_zsh
    set_zdotdir
    # Soft link
    link_xdg
    link_personal
    # oh-my-zsh
    install_oh-my-zsh
    custom_plugins
    custom_themes
    custom_completions

    success "Zsh completely installed and configured. Happy zsh!"
}

main
