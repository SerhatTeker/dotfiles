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
source "${ROOT}/install/common.sh"


DOWNLOAD_DIR=/tmp

_check_dep() {
    command_exists $1 || {
        msg_cli red "$1 not exist, first install it!" normal
        exit 1
    }
}

# For single usage of nvim.sh
check_base_deps() {
    _check_dep wget
    _check_dep node
    _check_dep npm
    _check_dep python3

    # rg
    if ! command_exists rg; then
        if ! command_exists brew; then
            msg_cli red "brew not exist, first install it!" normal
            return
        else
            brew install ripgrep
        fi
    fi

    msg_cli green "All deps exist, starting to install nvim..."
}


is_installed() {
    if command_exists nvim;then
        msg_cli red "Nvim already installed, first uninstall it!" normal
        exit 0
    fi
}

appimage() {
    local base_url="https://github.com/neovim/neovim/releases"
    local nightly_url="${base_url}/download/nightly/nvim.appimage"
    local stable_url="${base_url}/latest/download/nvim.appimage"
    local url=${stable_url}

    _check_dep wget

    wget \
        ${url} \
        --output-document "${DOWNLOAD_DIR}/nvim"

    chmod u+x "${DOWNLOAD_DIR}/nvim"
    cp "${DOWNLOAD_DIR}/nvim" "${XDG_BIN_HOME}/nvim"
}

# For single usage of nvim.sh
# Already linking in link.sh
link_config() {
    local dir="nvim"
    force_remove "${DOTFILES}/${dir}" "${XDG_CONFIG_HOME}/${dir}"
}

setup_plugins() {
    nvim +PlugInstall +qall
    nvim +UpdateRemotePlugins +qall
}


main() {
    is_installed
    # check_base_deps
    appimage
    link_config
    setup_plugins
}

main
