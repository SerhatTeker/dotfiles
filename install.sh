#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:
# ----------------------------------------------------------------------------#
#                      _           _        _ _       _
#                     (_)_ __  ___| |_ __ _| | |  ___| |__
#                     | | '_ \/ __| __/ _` | | | / __| '_ \
#                     | | | | \__ \ || (_| | | |_\__ \ | | |
#                     |_|_| |_|___/\__\__,_|_|_(_)___/_| |_|
#
# Author: Serhat Teker <me@serhatteker.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Install dotfiles
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=1091
source "${ROOT}/dotfiles/install/common.sh"


main_scripts() {
    # Run Install scripts
    declare -a installs=(
        "defaults"
        "brew"
        "zsh"
        "link"
        "tmux"
        "languages/python"
        "languages/rust"
        # "languages/node"
        "nvchad"
        "fonts"
    )

    for install in "${installs[@]}"; do
        bash "${ROOT}/install/${install}.sh"
    done
}

main() {
    info "Install started"

    sudo -v # Get sudo beforehand
    main_scripts
    install_dark_notify

    # TODO: Move to main brew file
    # https://github.com/cormacrelf/dark-notify
    brew install cormacrelf/tap/dark-notify

    success "Finished installation. Go build something!"
}

main "${@}"
