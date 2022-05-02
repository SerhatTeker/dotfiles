#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:
# ----------------------------------------------------------------------------#
#                                       _            _
#                       _ __   ___   __| | ___   ___| |__
#                      | '_ \ / _ \ / _` |/ _ \ / __| '_ \
#                      | | | | (_) | (_| |  __/_\__ \ | | |
#                      |_| |_|\___/ \__,_|\___(_)___/_| |_|
#
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Install node and npm via nvm
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail


# Locate the root directory
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# shellcheck source=scripts/common.sh
source "${ROOT}/common.sh"


# NOTE: Prefer manual install
nvm_manual_install() {
    local url="https://github.com/nvm-sh/nvm.git"

    export NVM_DIR="${XDG_CONFIG_HOME}/nvm" && (
      git clone ${url} "$NVM_DIR"
      cd "${NVM_DIR}"
      git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    ) && \. "${NVM_DIR}/nvm.sh"
}

# Alternative install method
# NOTE: Prefer manual install, since below adds environment and paths to .zshrc
nvm_auto_install() {
    local version="0.39.1"
    local url="https://raw.githubusercontent.com/nvm-sh/nvm/v${nvm_version}/install.sh"

    # install nvm
    wget -qO- ${url} | bash
}


main() {
    # Check already installed
    is_installed npm
    is_installed node

    # Install
    command_exists nvm || nvm_manual_install
    nvm install node        # install last version node
    nvm install-latest-npm  # install last comptabile version npm

    # Soft link
    force_remove "${DOTFILES}/node" "${XDG_CONFIG_HOME}/node" # link config. overwrites link.sh

    # Ensure install
    command_exists node \
        && success "Node installed at your system!"
}

main "$@"
