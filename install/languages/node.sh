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
# Author: Serhat Teker <me@serhatteker.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Install node and npm via nvm
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=scripts/common.sh
source "${ROOT}/common.sh"

NVM_VERSION="0.40.4"

nvm_install() {
    # wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/v${nvm_version}/install.sh" | bash
    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash
}

install_node_and_npm() {
    export NVM_DIR="${XDG_CONFIG_HOME}/nvm"

    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    nvm install node       # install last version node
    nvm install-latest-npm # install last compatible version npm
}

main() {
    nvm_install
    install_node_and_npm

    success "Node installed at your system."
}

main
