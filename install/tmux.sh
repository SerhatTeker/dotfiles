#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:
# ----------------------------------------------------------------------------#
#                      _                              _
#                     | |_ _ __ ___  _   ___  __  ___| |__
#                     | __| '_ ` _ \| | | \ \/ / / __| '_ \
#                     | |_| | | | | | |_| |>  < _\__ \ | | |
#                      \__|_| |_| |_|\__,_/_/\_(_)___/_| |_|
#
# Author: Serhat Teker <me@serhatteker.com>
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

install_tmux() {
    # if tmux already installed skip install
    command_exists tmux && return

    # install with brew but check brew installed first
    if ! command_exists brew; then
        error "brew not installed, first you need to install brew!"
        warn "Use your os brew.sh script"
        warn "Or follow https://docs.brew.sh/Installation"
        exit 1
    else
        brew install tmux
    fi
}

# Install tmux, tpm and plugins
plugins() {
    local target="${XDG_DATA_HOME}/tmux/plugins"

    # TODO: Check if the dir exists delete it
    rm -rf "${target}"
    mkdir -p "${target}"
    git clone https://github.com/tmux-plugins/tpm "${target}/tpm"

    # NOTE: This will be done automatically when opening a tmux instance
    #
    # INFO: We must inside tmux to run this
    # Reload TMUX environment so TPM is sourced:
    # tmux source "${XDG_CONFIG_HOME}/tmux/tmux.conf"
    # Install plugins
    # "${target}/tpm/bin/install_plugins"
}

main() {
    install_tmux
    force_remove "${DOTFILES}/tmux" "${XDG_CONFIG_HOME}/tmux"
    plugins
}

main
