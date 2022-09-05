#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:

# Install desired Gohugo to Linux or Mac ARM M1
# Usage:
# $ bash install/hugo.sh

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# TODO: Add old version as list
HUGO_VERSION="0.97.0"

SOURCE_DIR="/tmp/hugo_release"
DEST_DIR="${HOME}/.local/bin"

# Get OS and ARCH
if [[ "${OSTYPE}" == "darwin"* ]]; then
    OS_ARCH="macOS-ARM64"
else
    OS_ARCH="Linux-64bit"
fi

HUGO_TAR="hugo_extended_${HUGO_VERSION}_${OS_ARCH}.tar.gz"
DOWNLOAD_URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_TAR}"

get_release() {
    wget "${DOWNLOAD_URL}" -O "${SOURCE_DIR}/${HUGO_TAR}"
    tar -xvzf "${SOURCE_DIR}/${HUGO_TAR}" -C "${SOURCE_DIR}"
}

copy_bin() {
    cp -v "${SOURCE_DIR}/hugo" "${DEST_DIR}"
    # with version
    # cp -v "${SOURCE_DIR}/hugo" "${DEST_DIR}/hugo_${HUGO_VERSION}"
}

# Remove tmp source dir
remove_source() {
    rm -rf ${SOURCE_DIR}
}

main() {
    mkdir -pv ${SOURCE_DIR}

    get_release
    copy_bin
    remove_source
}

main
