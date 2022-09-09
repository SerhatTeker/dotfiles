#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:

# Install desired yubico desktop beta  to Linux or Mac ARM M1
# https://www.yubico.com/products/yubico-authenticator/yubico-authenticator-desktop-beta/
#
# Usage:
# $ bash install/apps/yubico.sh

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=1091
source "${ROOT}/common.sh"

APP="yubico"
VERSION="6.0.0-beta.1"

SOURCE_DIR="/tmp/${APP}_release"
DEST_DIR="${APPS}/${APP}"

# Get OS and ARCH
if is_macos; then
    OS_ARCH="mac"
else
    OS_ARCH="linux"
fi

TAR="yubioath-desktop-${VERSION}-${OS_ARCH}.tar.gz"
DOWNLOAD_URL="https://developers.yubico.com/yubioath-desktop/Beta/${TAR}"

get_release() {
    wget "${DOWNLOAD_URL}" -O "${SOURCE_DIR}/${TAR}"
    tar -xvzf "${SOURCE_DIR}/${TAR}" -C "${DEST_DIR}"
}

install_desktop() {
    local file="${DEST_DIR}/com.yubico.authenticator.desktop"

    # Use full paths
    sed -e -i "s#Exec.*#Exec=${DEST_DIR}/authenticator#" "${file}"
    sed -e -i "s#Icon.*#Exec=${DEST_DIR}/com.yubico.yubioath.png#" "${file}"

    # Install
    sudo desktop-file-install "${file}"
    sudo update-desktop-database
}

linux() {
    sudo apt insall pcscd
    get_release
    install_desktop
}

macos() {
    brew install --cask yubico-authenticator
}

main() {
    mkdir -pv "${SOURCE_DIR}" "${DEST_DIR}"
    if is_linux; then
        linux
    else
        macos
    fi
}

main
