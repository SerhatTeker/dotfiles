#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:


# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail


ROOT="${HOME}/dotfiles"

# shellcheck source=scripts/common.sh
source "${ROOT}/install/common.sh"


# Prefer manual install
nvm_manual_install() {
    local url="https://github.com/nvm-sh/nvm.git"

    export NVM_DIR="${XDG_CONFIG_HOME}/nvm" && (
      git clone ${url} "$NVM_DIR"
      cd "${NVM_DIR}"
      git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    ) && \. "${NVM_DIR}/nvm.sh"
}

# Prefer manual install, since below adds environment and paths to .zshrc
nvm_auto_install() {
    local version="0.39.1"
    local url="https://raw.githubusercontent.com/nvm-sh/nvm/v${nvm_version}/install.sh"

    # install nvm
    wget -qO- ${url} | bash
}


main() {
    if ! command_exists node; then
        msg_cli blue "Node not found, installing..." normal

        nvm_manual_install

        # install last node
        nvm install node
        # install last comptabile npm
        nvm install-latest-npm

        command_exists node \
            && msg_cli green "Node installed at your system!" normal
    else
        msg_cli yellow "Node already installed at your system." normal
    fi
}

main
