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

install_tmux() {
    # if tmux already installed skip
    command_exists tmux && return

    is_linux && {
        sudo apt install tmux
        return 0
    }

    # install with brew but check brew installed first
    if ! command_exists brew; then
        msg_cli red "brew not installed, first you need to install brew!" normal
        msg_cli yellow "Use your os brew.sh script" normal
        msg_cli yellow "Or follow https://docs.brew.sh/Installation" normal
        exit 1
    else
        brew install tmux
    fi
}

# Install tmux tpm and plugins
plugins() {
    local target="${XDG_DATA_HOME}/tmux/plugins"
    mkdir -p "${target}"
    git clone https://github.com/tmux-plugins/tpm "${target}/tpm/tpm"

    # Reload TMUX environment so TPM is sourced:
    tmux source "${XDG_CONFIG_HOME}/tmux/tmux.conf"

    # Install plugins
    "${target}/tpm/bin/install_plugins"
}

main() {
    install_tmux
    force_remove "${DOTFILES}/tmux" "${XDG_CONFIG_HOME}/tmux" # link config. overwrites link.sh
    plugins
}

main "$@"
