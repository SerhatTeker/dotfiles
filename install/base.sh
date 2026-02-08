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
# Author: Serhat Teker <me@serhatteker.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=1091
source "${ROOT}/install/common.sh"

# TODO: Check still needed
# TODO: Check for whether VM or PC
apps_pc() {
    local dir="${1}"
    bash "${dir}/apps/yubico.sh"
    bash "${dir}/apps/bitwarden-cli.sh"
    # bash "${dir}/apps/gopass.sh" # INFO: disabled since gnupg dep is pain
}

install_lib_and_apps() {
    declare -a installs=(
        "zsh.sh"
        "link.sh"
        "tmux.sh"
        "languages/python.sh"
        "languages/rust.sh"
        # "languages/node.sh"
        "nvchad.sh"
        "fonts.sh"
    )

    for install in "${installs[@]}"; do
        bash "${ROOT}/install/${install}"
    done
}

main() {
    info "Started base installation"

    sudo -v # Get sudo beforehand
    bash "${ROOT}/install/macos/base.sh"
    install_lib_and_apps

    success "Finished base installation"
}

main
