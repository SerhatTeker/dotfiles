#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:
# ----------------------------------------------------------------------------#
#                         _                          _
#                        | |__   __ _ ___  ___   ___| |__
#                        | '_ \ / _` / __|/ _ \ / __| '_ \
#                        | |_) | (_| \__ \  __/_\__ \ | | |
#                        |_.__/ \__,_|___/\___(_)___/_| |_|
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=1091
source "${ROOT}/install/common.sh"

# TODO: Add bash-language-server install
os_base() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        bash "${ROOT}/install/linux/base.sh"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        bash "${ROOT}/install/macos/base.sh"
    fi
}

apps() {
    info "Started apps installation"

    mkdir -p "${HOME}/apps"

    local dir="${ROOT}/install"
    bash "${dir}/apps/yubico.sh"
    bash "${dir}/apps/bitwarden-cli.sh"
    bash "${dir}/apps/gopass.sh"
    bash "${dir}/apps/alacritty.sh"
    # rclone
    curl https://rclone.org/install.sh | sudo bash
}

main() {
    info "Started base installation"

    sudo -v # Get sudo beforehand

    os_base
    apps

    local install_root="${ROOT}/install"

    declare -a installs=(
        "zsh.sh"
        "link.sh"
        "tmux.sh"
        "languages/node.sh"
        "languages/rust.sh"
        "nvim.sh"
        "lvim.sh"
        "fonts.sh"
    )

    for install in "${installs[@]}"; do
        bash "${install_root}/${install}"
    done

    success "Finished base installation"
}

main
