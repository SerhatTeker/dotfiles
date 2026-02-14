#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:
# ----------------------------------------------------------------------------#
#                                        _         _
#                         _ __ _   _ ___| |_   ___| |__
#                        | '__| | | / __| __| / __| '_ \
#                        | |  | |_| \__ \ |_ _\__ \ | | |
#                        |_|   \__,_|___/\__(_)___/_| |_|
#
#
# Author: Serhat Teker <me@serhatteker.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Install rust toolchain and cargo
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=1091
source "${ROOT}/common.sh"

RUST_HOME="${HOME}/rust"
RUSTUP_HOME="${RUST_HOME}/.rustup"
CARGO_HOME="${RUST_HOME}/.cargo"
RUSTUP_BIN="${CARGO_HOME}/bin/rustup"

# in case of need
_uninstall() {
    # rustup self uninstall
    rm -rf "${RUST_HOME}"
}

# Install rust for macOS, Linux, or another Unix-like OS
install() {
    mkdir -p "${RUSTUP_HOME}"
    # https://rust-lang.org/tools/install/
    # no-interactive: continue without user prompt
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    # default command
    # 1) Proceed with standard installation (default - just press enter)
    # curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

main() {
    # Install if not present
    [ ! -d "${RUST_HOME}" ] && install

    source "${CARGO_HOME}/env"

    "${RUSTUP_BIN}" default stable

    # check_rights
    "${RUSTUP_BIN}" override set stable
    "${RUSTUP_BIN}" update stable

    # Ensure install
    command_exists "${CARGO_HOME}/bin/cargo" -V &&
        success "Rust installed at your system"
}

main
# _uninstall
