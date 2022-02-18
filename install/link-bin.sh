#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:

# Make soft links for bin to ~/.local/bin

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail


SOURCE=${HOME}/dotfiles/bin
TARGET=${HOME}/.local/bin

find \
    ${SOURCE} \
    -type f \
    -name "*" \
    ! -name "*.md" \
    -print0 | xargs -0 \
    cp -s -f --target-directory=${TARGET}
