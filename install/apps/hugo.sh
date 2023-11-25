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

SOURCE_DIR="/tmp/hugo_release"
DEST_DIR="${HOME}/.local/bin"

# Get OS and ARCH
if [[ "${OSTYPE}" == "darwin"* ]]; then
    OS_ARCH="macOS-ARM64"
else
    OS_ARCH="Linux-64bit"
fi


version_0_97() {
    HUGO_VERSION="0.97.0"
    HUGO_TAR="hugo_extended_${HUGO_VERSION}_${OS_ARCH}.tar.gz"
    DOWNLOAD_URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_TAR}"

    wget "${DOWNLOAD_URL}" -O "${SOURCE_DIR}/${HUGO_TAR}"
    tar -xvzf "${SOURCE_DIR}/${HUGO_TAR}" -C "${SOURCE_DIR}"

    cp -v "${SOURCE_DIR}/hugo" "${DEST_DIR}"

    rm -rf ${SOURCE_DIR}
}
version_0_81() {
    HUGO_VERSION="0.81.0"
    HUGO_TAR="hugo_extended_${HUGO_VERSION}_${OS_ARCH}.tar.gz"
    DOWNLOAD_URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_TAR}"

    wget "${DOWNLOAD_URL}" -O "${SOURCE_DIR}/${HUGO_TAR}"
    tar -xvzf "${SOURCE_DIR}/${HUGO_TAR}" -C "${SOURCE_DIR}"

    cp -v "${SOURCE_DIR}/hugo" "${DEST_DIR}/hugo_${HUGO_VERSION}"

    rm -rf ${SOURCE_DIR}
}

main() {
    mkdir -pv ${SOURCE_DIR}

    version_0_97
    version_0_81
}

main
