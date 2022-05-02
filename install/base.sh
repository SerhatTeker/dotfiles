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
#
# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# shellcheck source=scripts/common.sh
source "${ROOT}/install/common.sh"

os_base() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        bash "${ROOT}/install/linux/base.sh"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        bash "${ROOT}/install/macos/base.sh"
    else
        echo "No install configuration for ${OSTYPE}"
        exit 1
    fi
}

brew_deps() {
    brew install \
        git \
        ripgrep
}

main() {
    os_base

    bash "${ROOT}/python/zsh.sh"
    bash "${ROOT}/python/python.sh"
    bash "${ROOT}/python/nvim.sh"
    bash "${ROOT}/python/tmux.sh"
    bash "${ROOT}/python/fonts.sh"
    bash "${ROOT}/python/link.sh"

    brew_deps
}

main
