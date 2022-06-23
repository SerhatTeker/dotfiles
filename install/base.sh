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

# shellcheck source=scripts/common.sh
source "${ROOT}/install/common.sh"

# TODO: Add bash-language-server install
os_base() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        bash "${ROOT}/install/linux/base.sh"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        bash "${ROOT}/install/macos/base.sh"
    fi
}

main() {
    info "Started base installation"

    os_base

    local dir="${ROOT}/install"
    bash "${dir}/zsh.sh"
    bash "${dir}/link.sh"
    bash "${dir}/tmux.sh"
    bash "${dir}/languages/python.sh"
    bash "${dir}/languages/node.sh"
    bash "${dir}/languages/golang.sh"
    bash "${dir}/languages/rust.sh"
    bash "${dir}/nvim.sh"
    bash "${dir}/fonts.sh"

    success "Finished base installation"
}

main
