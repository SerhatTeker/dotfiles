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
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=1091
source "${ROOT}/install/common.sh"

NVIM_CONFIG_DIR="${HOME}/.config/nvim"



install_dep() {
    local RUST_HOME="${HOME}/rust"
    local CARGO_HOME="${RUST_HOME}/.cargo"
    local RUSTUP_HOME="${RUST_HOME}/.rustup"

    source "${CARGO_HOME}/env"

    cargo install --locked tree-sitter-cli
    info "Dependencies installed."
}

link_config() {
    [ -d "${NVIM_CONFIG_DIR}" ] && rm -rf "${NVIM_CONFIG_DIR}"
    force_remove "${DOTFILES}/nvchad/improved" "${NVIM_CONFIG_DIR}"
}


main() {
    info "Started NvChad install"

    install_dep
    link_config

    success "NvChad install completed."
}

main
