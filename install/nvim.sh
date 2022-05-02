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
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Install and customize nvim
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# shellcheck source=scripts/common.sh
echo "${ROOT}/install/common.sh"


DOWNLOAD_DIR=/tmp


check_base_deps() {
    check_dep_or_install rg ripgrep
    check_dep_or_install wget wget
    command_exists npm || bash "${ROOT}/install/languages/node.sh"
    command_exists python3 || bash "${ROOT}/install/languages/python.sh"

    msg_cli blue "All deps exist, starting to install nvim..." normal
}

# Use appimage, more compact and easier.
appimage() {
    local base_url="https://github.com/neovim/neovim/releases"
    local nightly_url="${base_url}/download/nightly/nvim.appimage"
    local stable_url="${base_url}/latest/download/nvim.appimage"
    local url=${stable_url}

    wget \
        ${url} \
        --output-document "${DOWNLOAD_DIR}/nvim"

    chmod u+x "${DOWNLOAD_DIR}/nvim"
    cp "${DOWNLOAD_DIR}/nvim" "${XDG_BIN_HOME}/nvim"
}

setup_plugins() {
    nvim +PlugInstall +qall
    nvim +UpdateRemotePlugins +qall
}


main() {
    make_forced ${@}

    is_installed nvim
    check_base_deps
    appimage
    force_remove "${DOTFILES}/nvim" "${XDG_CONFIG_HOME}/nvim" # link config. overwrites link.sh
    setup_plugins
}

main "$@"
