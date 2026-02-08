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

# Install rust for macOS, Linux, or another Unix-like OS
install() {
    mkdir -p "${RUSTUP_HOME}"
    # https://rust-lang.org/tools/install/
    # no-interactive: continue without user prompt
    # 1) Proceed with standard installation (default - just press enter)
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    # default command
    # curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

# in case of need
_uninstall() {
    rustup self uninstall
    rm -rf $"{RUSTUP_HOME}"
}

main() {
    export RUSTUP_HOME="${RUST_HOME}/.rustup"
    export CARGO_HOME="${RUST_HOME}/.cargo"

    # Install if not present
    command_exists cargo -V || install

    # check_rights
    "${CARGO_HOME}/.cargo/bin/rustup" override set stable
    "${CARGO_HOME}/.cargo/bin/rustup" update stable

    # Ensure install
    command_exists "${CARGO_HOME}/.cargo/bin/cargo" -V &&
        success "Rust installed at your system"
}

main
