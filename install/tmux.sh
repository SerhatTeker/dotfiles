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
    check_dep brew
    brew install tmux
}

plugins() {
    local target="${XDG_DATA_HOME}/tmux/plugins"

    mkdir -p "${target}"
    git clone https://github.com/tmux-plugins/tpm "${target}/tpm"
}

main() {
    install_tmux
    force_remove "${DOTFILES}/tmux" "${XDG_CONFIG_HOME}/tmux"
    plugins

    success "tmux and tpm installed."
}

main
