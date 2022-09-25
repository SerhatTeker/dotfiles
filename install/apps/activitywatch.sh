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

APP="aw"
VERSION="0.12.0"

SOURCE_DIR="/tmp/${APP}"
DEST_DIR="${APPS}/activitywatch"

# Get ARCH
if [[ "${OSTYPE}" == "darwin"* ]]; then
    OS_ARCH="mac"
else
    OS_ARCH="linux-x86_64"
fi

TAR="activitywatch-v${VERSION}-${OS_ARCH}.zip"
DOWNLOAD_URL="https://github.com/ActivityWatch/activitywatch/releases/download/v${VERSION}/${TAR}"

get_release() {
    wget "${DOWNLOAD_URL}" -O "${SOURCE_DIR}/${TAR}"

    local zipfile="${SOURCE_DIR}/${TAR}"
    local unzipdir="${SOURCE_DIR}"

    unzip -d "${unzipdir}" "${zipfile}"
    cp -r "${SOURCE_DIR}/activitywatch" "${APPS}"
}

# Create desktop file
desktop() {
    # sudo cp "${SOURCE_DIR}/extra/logo/alacritty-term.svg" /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install "${DEST_DIR}/aw-qt.desktop"
    sudo update-desktop-database
}

# Remove tmp source dir
remove_source() {
    rm -rf "${SOURCE_DIR}/activitywatch"
}

main() {
    mkdir -pv "${SOURCE_DIR}" "${DEST_DIR}"
    get_release
    desktop
}

main
