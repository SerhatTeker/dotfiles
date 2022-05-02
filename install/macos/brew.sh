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
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# shellcheck source=scripts/common.sh
source "${ROOT}/common.sh"


install_brew() {
    command_exists brew && return

    # Install Homebrew to $HOME/.homebrew instead of /usr/local:
    git clone https://github.com/Homebrew/brew.git ${HOME}/.homebrew
    # check brew installed
    which brew
    # close analytics
    brew analytics off
}

brew_bundle() {
    brew bundle install --file="${ROOT}/Brewfile"
}

# NOTE: Disabled
# Install universal-ctags
# https://gist.github.com/nazgob/1570678
# https://docs.ctags.io/en/latest/osx.html#building-with-homebrew
ictags() {
    brew tap universal-ctags/universal-ctags
    brew install --HEAD universal-ctags
}

main() {
    install_brew
    brew_bundle
}

main "$@"
