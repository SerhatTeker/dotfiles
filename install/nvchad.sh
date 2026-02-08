#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:
# ----------------------------------------------------------------------------#
#                                  _                 _
#                       _ ____   _(_)_ __ ___    ___| |__
#                      | '_ \ \ / / | '_ ` _ \  / __| '_ \
#                      | | | \ V /| | | | | | |_\__ \ | | |
#                      |_| |_|\_/ |_|_| |_| |_(_)___/_| |_|
#
#
# Author: Serhat Teker <me@serhatteker.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Install and customize nvim
# Default nvim version is 0.6.1. Pass $NVIM_VERSION variable to overwrite it
# NVIM_VERSION=0.6.1 bash nvim.sh
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=1091
source "${ROOT}/install/common.sh"

install_dep() {
    # Ripgrep
    check_dep rg
    # NvChad
    cargo install --locked tree-sitter-cli
    msg "Dependencies installed."
}

clone_nvchad() {
    # TODO: Replace with your configs
    git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
}


main() {
    info "Started NvChad install"

    # If nvim bin already exists quit
    if command_exists "nvim"; then
        install_dep
        clone_nvchad

        success "NvChad install completed."
    else
        error "NvChad not installed, install it first."
        exit 1
    fi
}

main
