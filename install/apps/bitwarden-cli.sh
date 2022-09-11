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

APP="bitwarden-cli"
VERSION="1.22.1"

SOURCE_DIR="/tmp/${APP}_release"
DEST_DIR="${XDG_BIN_HOME}"

# Get OS and ARCH
if [[ "${OSTYPE}" == "darwin"* ]]; then
    OS_ARCH="mac"
else
    OS_ARCH="linux"
fi

TAR="bw-${OS_ARCH}-${VERSION}.zip"
DOWNLOAD_URL="https://github.com/bitwarden/cli/releases/download/v${VERSION}/${TAR}"

get_release() {
    wget -O "${SOURCE_DIR}/${TAR}" "${DOWNLOAD_URL}"
    unzip -d "${SOURCE_DIR}" "${SOURCE_DIR}/${TAR}"
}

copy_bin() {
    local bin="${SOURCE_DIR}/bw"
    chmod +x "${bin}"
    cp "${bin}" "${DEST_DIR}"
}

main() {
    mkdir -pv "${SOURCE_DIR}" "${DEST_DIR}"
    get_release
    copy_bin
}

main
