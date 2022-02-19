#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:

# Make soft links for bin to ~/.local/bin

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail


# Locate the root directory
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# shellcheck source=scripts/common.sh
source "${ROOT}/install/common.sh"


SOURCE=${HOME}/dotfiles/bin
TARGET=${HOME}/.local/bin

# With find and cp
_alt() {
    if is_linux; then
        _cp=cp
    elif is_macos; then
        if command_exists gcp; then
            _cp=gcp
        else
            exit 1
        fi
    fi

    find \
        ${SOURCE} \
        -type f \
        -name "*" \
        ! -name "*.md" \
        -print0 | xargs -0 \
        ${_cp} -s -f --target-directory=${TARGET}
}

# Link all bins
ln -sf ${SOURCE}/* ${TARGET}
msg_cli green "Bin files linked to ${TARGET}"
