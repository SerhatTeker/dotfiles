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

APP="alacritty"
SOURCE_DIR="/tmp/${APP}"

_linux() {
    # This installs alacritty terminal on ubuntu
    # You have to have rust/cargo installed for this to work
    command_exists cargo -V || error "Cargo not installed on your \$PATH"

    # Install required deps
    command_exists python3 --version || error "Python3 not installed on your \$PATH"
    sudo apt-get install -y \
        cmake \
        pkg-config \
        libfreetype6-dev \
        libfontconfig1-dev \
        libxcb-xfixes0-dev \
        libxkbcommon-dev

    # Download, compile and install Alacritty
    git -C "${SOURCE_DIR}" clone https://github.com/jwilm/alacritty
    cd "${SOURCE_DIR}" && cargo build --release

    # Copy binary to path
    sudo cp "${SOURCE_DIR}/target/release/${APP}" "${XDG_BIN_HOME}/${APP}"

    # Add Man-Page entries
    sudo mkdir -p /usr/local/share/man/man1
    gzip -c "${SOURCE_DIR}/extra/alacritty.man" |
        sudo tee /usr/local/share/man/man1/alacritty.1.gz >/dev/null
    gzip -c "${SOURCE_DIR}/extra/alacritty-msg.man" |
        sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz >/dev/null

    # Shell completion
    sudo cp "${SOURCE_DIR}/extra/completions/_alacritty" "${ZSH}/completions"

    # Create desktop file
    # cp Alacritty.desktop "${XDG_DATA_HOME}/applications"
    sudo cp "${SOURCE_DIR}/extra/logo/alacritty-term.svg" /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install "${SOURCE_DIR}/extra/linux/Alacritty.desktop"
    sudo update-desktop-database

    # Use Alacritty as default terminal (Ctrl + Alt + T)
    # gsettings set org.gnome.desktop.default-applications.terminal exec "alacritty"
}

_macos() {
    brew install --cask alacritty
}

_msg() {
    success "${APP} is successfully installed"
}

main() {
    mkdir -pv "${SOURCE_DIR}"
    if is_linux; then
        _linux
    else
        _macos
    fi
    _msg
}

main
