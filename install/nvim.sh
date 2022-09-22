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
# Default nvim version is 0.6.1. Pass $NVIM_VERSION variable to overwrite it
# NVIM_VERSION=0.6.1 bash nvim.sh
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=1091
source "${ROOT}/install/common.sh"

DOWNLOAD_DIR=/tmp
# NVIM_VERSION="${NVIM_VERSION:-"0.7.2"}"   # stable
NVIM_VERSION="${NVIM_VERSION:-"nightly"}"

exists_or_install() {
    if ! command_exists "${1}"; then
        if is_linux; then
            sudo apt install "${2}"
        else
            command_exists brew || warn "You need Homebrew to install rg"
            bash "${ROOT}/install/brew.sh"
            brew install "${2}"
        fi
    fi
}

check_base_deps() {
    exists_or_install rg ripgrep
    exists_or_install wget wget
    command_exists npm || bash "${ROOT}/install/languages/node.sh"
    command_exists python3 || bash "${ROOT}/install/languages/python.sh"

    info "All deps exist, starting to install nvim..."
}

# Use appimage, more compact and easier.
appimage() {
    local base_url="https://github.com/neovim/neovim/releases"
    local nightly_url="${base_url}/download/nightly"
    local stable_url="${base_url}/latest/download"
    local version_url="${base_url}/download/v${NVIM_VERSION}"

    # Nightly version
    if [ "$NVIM_VERSION" == "nightly" ]; then
        local url="${nightly_url}/nvim.appimage"
    # Stable version
    elif [ "$NVIM_VERSION" == "stable" ]; then
        local url="${stable_url}/nvim.appimage"
    # Specific version
    else
        local url="${version_url}/nvim.appimage"
    fi

    local file="nvim-${NVIM_VERSION}"

    wget \
        "${url}" \
        --output-document "${DOWNLOAD_DIR}/${file}"

    chmod u+x "${DOWNLOAD_DIR}/${file}"
    cp "${DOWNLOAD_DIR}/${file}" "${XDG_BIN_HOME}/${file}"
    force_remove "${XDG_BIN_HOME}/${file}" "${XDG_BIN_HOME}/nvim"
}

setup_plugins() {
    info "Starting setup plugins"
    ${nvim_bin} +PlugInstall +qall
    ${nvim_bin} +UpdateRemotePlugins +qall
}

macos_brew() {
    # Nightly version
    if [ "$NVIM_VERSION" == "nightly" ]; then
        brew install --HEAD neovim
    # Stable version
    else
        brew install neovim
    fi
}

nvim_os() {
    if is_linux; then
        appimage
        local nvim_bin="${XDG_BIN_HOME}/nvim"
    else
        macos_brew
        local nvim_bin="${HOME}/.homebrew/nvim"
    fi
    setup_plugins
}

main() {
    info "Started nvim install"

    # If nvim bin already exists quit
    if command_exists "nvim"; then
        return
    fi

    check_base_deps
    nvim_os
    force_remove "${DOTFILES}/nvim" "${XDG_CONFIG_HOME}/nvim" # link config. overwrites link.sh

    success "Finished nvim install"
}

main "$@"
