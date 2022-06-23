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

# shellcheck source=scripts/common.sh
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

    # msg_cli green "Dotfiles configs linked to ${XDG_CONFIG_HOME}"
}

# Link all bins
bins() {
    local source=${HOME}/dotfiles/bin
    local target=${HOME}/.local/bin

    ln -sf ${source}/* ${target}
    # msg_cli green "Bin files linked to ${target}"
}

dot_gnu() {
    [ -f "${SYSBAK}/.gnupg" ] || return 0

    local source="${SYSBAK}/.gnupg"
    local target="${HOME}/.gnupg"

    force_remove "${source}" "${target}"
    # make directory unreadable by others
    chmod -R o-rx "${target}"
    # make symlink available only to current user
    chmod 700 "${target}"
    # msg_cli green ".gnupg linked"
}

# TODO: Check if true
# other stuff
home_others() {
    force_remove "${DOTFILES}/ctags/.ctags" "${HOME}/.ctags"
    force_remove "${DOTFILES}/etc/.sqliterc" "${HOME}/.sqliterc"
    # msg_cli green ".gnupg linked"
}

containers() {
    force_remove "${DOTFILES}/kube" "${XDG_CONFIG_HOME}/kube"
    # msg_cli green "Containers linked"
}

main() {
    dot_configs
    bins
    dot_gnu
    home_others
    containers

    msg_cli green "All dotfiles linked"
}

main "$@"
