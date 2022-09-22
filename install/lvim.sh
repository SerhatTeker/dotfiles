#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:
# ----------------------------------------------------------------------------#
#                        _       _                 _
#                       | |_   _(_)_ __ ___    ___| |__
#                       | \ \ / / | '_ ` _ \  / __| '_ \
#                       | |\ V /| | | | | | |_\__ \ | | |
#                       |_| \_/ |_|_| |_| |_(_)___/_| |_|
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Install and customize lvim
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=1091
source "${ROOT}/install/common.sh"

# Nvim is needed
check_base_deps() {
    command_exists nvim || bash "${ROOT}/install/nvim.sh"
    info "All deps exist, starting to install lvim..."
}

copy_snapshot() {
    local snapshot_dir="${XDG_CACHE_HOME}/lunarvim/snapshots"

    mkdir -p "${snapshot_dir}"
    cp "${DOTFILES}/lvim/snapshots/default.json" "${snapshot_dir}"
}

# No install dependencies since installing already in install/nvim.sh
install_lvim() {
    # Require Neovim 0.8+
    LV_BRANCH=rolling \
        bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh) \
        --no-install-dependencies
}

_configure() {
    "${XDG_BIN_HOME}/lvim" --headless \
        -c "lua require('lvim.core.log'):set_level([[warn]])" \
        -c 'autocmd User PackerComplete quitall' \
        -c "${1}"
}

configure() {
    # INFO: _configure not working currently, run manually
    # https://github.com/wbthomason/packer.nvim/issues/751
    # _configure 'PackerSync'

    info "Run :PackerSync"
}

main() {
    info "Started lvim install"

    check_base_deps
    copy_snapshot
    install_lvim
    force_remove "${DOTFILES}/lvim" "${XDG_CONFIG_HOME}/lvim" # link config. overwrites link.sh
    configure

    success "Finished lvim install"
}

main "$@"
