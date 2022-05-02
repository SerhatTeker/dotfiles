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
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# ----------------------------------------------------------------------------#


# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# shellcheck source=scripts/common.sh
source "${ROOT}/install/common.sh"

# TODO: Add function
install_tmux() {
    :
}

# No need: auto install tpm and plugins from .tmux.conf
# Install tmux tpm plugin manager
tpm() {
    target="${XDG_DATA_HOME}/tmux/plugins"

    mkdir -p ${target}

    git clone \
        https://github.com/tmux-plugins/tpm \
        "${target}/tpm/tpm"

    # Reload TMUX environment so TPM is sourced:
    tmux source "${XDG_CONFIG_HOME}/tmux/tmux.conf"

    # Install plugins
    "${target}/tpm/bin/install_plugins"
}

main() {
    install_tmux
}

main
