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

# shellcheck source=scripts/common.sh
source "${ROOT}/install/common.sh"

check_base_deps() {
    command_exists nvim || bash "${ROOT}/install/nvim.sh"
    info "All deps exist, starting to install lvim..."
}

# Hacky and ugly way to get "PackerSnapshotDone" until PR merged
# Add PackerSnapshotDone commit from #898 PR
overwrite_packer() {
    local install_path="${XDG_DATA_HOME}/lunarvim/site/pack/packer/start/packer.nvim"

    git -C "${install_path}" fetch origin "pull/898/head"
    git -C "${install_path}" cherry-pick "e070db37f5ad3733a790912cb247c1036888d473"
}

copy_snapshot() {
    local snapshot_dir="${XDG_CACHE_HOME}/lunarvim/snapshots"

    mkdir -p "${snapshot_dir}"
    cp "${DOTFILES}/lvim/snapshots/default.json" "${snapshot_dir}"
}

# No install dependencies since installing already in install/nvim.sh
install_lvim() {
    LV_BRANCH=rolling \
        bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh) \
        --no-install-dependencies
}

_configure() {
    "${XDG_BIN_HOME}/lvim" --headless \
        -c "lua require('lvim.core.log'):set_level([[warn]])" \
        -c 'autocmd User PackerComplete quitall' \
        -c "$1"
}

configure() {
    # INFO: _configure not working currently, run manually
    # https://github.com/wbthomason/packer.nvim/issues/751
    #
    # _configure 'PackerSync'

    info "Run :PackerSync"
}

main() {
    info "Started lvim install"

    check_base_deps
    copy_snapshot
    install_lvim
    force_remove "${DOTFILES}/lvim" "${XDG_CONFIG_HOME}/lvim" # link config. overwrites link.sh
    overwrite_packer
    configure

    success "Finished lvim install"
}

main "$@"