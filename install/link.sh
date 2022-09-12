#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:
# ----------------------------------------------------------------------------#
#                           _ _       _          _
#                          | (_)_ __ | | __  ___| |__
#                          | | | '_ \| |/ / / __| '_ \
#                          | | | | | |   < _\__ \ | | |
#                          |_|_|_| |_|_|\_(_)___/_| |_|
#
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Make soft links for bin to ~/.local/bin
# Make soft links for dotfiles configs to ~/.config
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=1091
source "${ROOT}/install/common.sh"

# Link all configs
dot_configs() {
    declare -a arr=(
        "alacritty"
        "bat"
        "git"
        "gh"
        "fd"
        "httpie"
        "i3"
        "lsd"
        "rg"
        "node"
        "nvim"
        "rofi"
        "tmux"
        "zsh"
    )

    for dir in "${arr[@]}"; do
        force_remove "${DOTFILES}/${dir}" "${XDG_CONFIG_HOME}/${dir}"
    done
}

# Link all bins
bins() {
    local source="${DOTFILES}/bin"
    local target="${XDG_BIN_HOME}"

    ln -sf "${source}/"* "${target}"
}

# other stuff
home_others() {
    force_remove "${DOTFILES}/ctags/.ctags" "${HOME}/.ctags"
    force_remove "${DOTFILES}/reldb/.sqliterc" "${HOME}/.sqliterc"
}

# TODO: full.sh . Link after docker&k8s installed
containers() {
    force_remove "${DOTFILES}/kube" "${XDG_CONFIG_HOME}/kube"
}

main() {
    dot_configs
    bins
    home_others
    containers

    msg_cli green "All dotfiles linked"
}

main "$@"
