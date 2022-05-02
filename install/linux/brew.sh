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
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# shellcheck source=scripts/common.sh
source "${ROOT}/common.sh"


brew_deps() {
    sudo apt install -y \
        build-essential \
        curl \
        file \
        git \
        procps
}

brew_install() {
    NONINTERACTIVE=1 \
        bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    which brew          # check brew installed
    brew analytics off  # close analytics
}

brew_bundle() {
    # TODO: make a separate linux Brewfile
    brew bundle --file=${ROOT}/Brewfile
}

brew_main() {
    brew_install
    brew_bundle
}

brew_main
