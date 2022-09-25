#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=1091
source "${ROOT}/common.sh"

APP="gopass"
VERSION="1.14.6"

SOURCE_DIR="/tmp/${APP}_release"

main() {
    mkdir -pv "${SOURCE_DIR}"

    if macos; then
        brew install gopass
    # TODO: Add linux arm as well
    # Linux amd64
    else
        local DEB="gopass_${VERSION}_linux_amd64.deb"
        local DOWNLOAD_URL_BASE="https://github.com/gopasspw/gopass/releases/download/"
        local DOWNLOAD_URL="${DOWNLOAD_URL_BASE}/v${VERSION}/${DEB}"

        wget "${DOWNLOAD_URL}" -O "${SOURCE_DIR}/${DEB}"
        sudo dpkg -i "${SOURCE_DIR}/${DEB}"
    fi
}

main
