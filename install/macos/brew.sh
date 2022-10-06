#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:

# Install brew and bundle
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

install_brew() {
    # If brew presents
    command_exists brew && return

    # If ~/.homebrew presents
    [[ -d "${HOME}/.homebrew" ]] && return

    # Install Homebrew to $HOME/.homebrew instead of /usr/local:
    git clone https://github.com/Homebrew/brew.git "${HOME}/.homebrew"

    # Setup install
    cd "${HOME}/" &&
        eval "$(.homebrew/bin/brew shellenv)"
    brew update --force --quiet
    chmod -R go-w "$(brew --prefix)/share/zsh"

    # check brew installed
    which brew

    # close analytics
    brew analytics off

    # install cask
    brew install cask
}

brew_bundle_base() {
    brew bundle install --file="${ROOT}/install/macos/Brewfile.base.macos"
}

# NOTE: Disabled
# Install universal-ctags
# https://gist.github.com/nazgob/1570678
# https://docs.ctags.io/en/latest/osx.html#building-with-homebrew
ictags() {
    brew tap universal-ctags/universal-ctags
    brew install --HEAD universal-ctags
}

# TODO: Add full opt and func
main() {
    install_brew
    brew_bundle_base
}

main "$@"
