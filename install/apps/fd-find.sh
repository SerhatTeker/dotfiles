#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:

# Install desired fd-find to Linux or Mac ARM M1
# Usage:
# $ bash fd-find

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

VERSION="8.4.0"

SOURCE_DIR="/tmp/fd-find"
DEST_DIR="${HOME}/.local/bin"

# Get OS and ARCH
if [[ "${OSTYPE}" == "darwin"* ]]; then
    OS_ARCH="macOS-ARM64"
    brew install fd
else
    OS_ARCH="x86_64-unknown-linux-gnu"
fi

DIR="fd-v${VERSION}-${OS_ARCH}"
TAR="${DIR}.tar.gz"
DOWNLOAD_URL="https://github.com/sharkdp/fd/releases/download/v${VERSION}/${TAR}"

get_release() {
    wget "${DOWNLOAD_URL}" -O "${SOURCE_DIR}/${TAR}"
    tar -xvzf "${SOURCE_DIR}/${TAR}" -C "${SOURCE_DIR}"
}

move_bin() {
    mv -v "${SOURCE_DIR}/${DIR}/fd" "${DEST_DIR}"
    # with version
    # cp -v "${SOURCE_DIR}/${DIR}/fd" "${DEST_DIR}/fd_${VERSION}"
}

# Remove tmp source dir
remove_source() {
    rm -rf "${SOURCE_DIR}"
}

main() {
    mkdir -pv "${SOURCE_DIR}"

    get_release
    move_bin
    remove_source
}

main
