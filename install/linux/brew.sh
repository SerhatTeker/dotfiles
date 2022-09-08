#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:

# Install and setup brew and packages
# Usage:
# $ bash brew.sh

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=1091
source "${ROOT}/common.sh"

brew_deps() {
    sudo apt install -y \
        build-essential \
        file \
        curl \
        git \
        procps
}

brew_install() {
    command_exists brew && return

    NONINTERACTIVE=1 \
        bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    which brew         # check brew installed
    brew analytics off # close analytics
}

brew_bundle() {
    brew bundle install --file="${ROOT}/linux/Brewfile.linux"
}

brew_main() {
    brew_install
    brew_bundle
}

brew_main
