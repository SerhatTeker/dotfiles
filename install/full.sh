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
        bash "${ROOT}/install/linux/full.sh"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        bash "${ROOT}/install/macos/full.sh"
    fi
}

apps() {
    info "Started apps installation"

    mkdir -p "${HOME}/apps"

    local dir="${ROOT}/install"
    bash "${dir}/apps/aw.sh"
    bash "${dir}/apps/hugo.sh"
    bash "${dir}/apps/spotify.sh"
}

main() {
    info "Started base installation"

    os_base
    apps

    local dir="${ROOT}/install"
    bash "${dir}/brew.sh"
    bash "${dir}/languages/python.sh"
    bash "${dir}/languages/golang.sh"

    success "Finished full installation"
}

main
