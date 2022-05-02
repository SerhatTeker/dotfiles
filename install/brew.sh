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
source "${ROOT}/install/common.sh"


install_brew() {
    if is_linux; then
        bash "${ROOT}/install/linux/brew.sh" $@
    else
        bash "${ROOT}/install/macos/brew.sh" $@
    fi
}

full_or_min() {
    if [[ -z "${NO_INTERACTIVE-}" ]]; then
        install_brew --minimal
        return
    fi

    printf '%sMinimal or Full install (m/f)%s ' ${COLOR_YELLOW} ${COLOR_RESET}
    read -r opt
    case ${opt} in
        m*|M*|"") install_brew --minimal
            ;;
        f*|F*) install_brew --full
            ;;
        *) error "Unkown flag <$@>"
            ;;
    esac
}

main() {
    if ! command_exists brew; then
        printf '%sHomebrew not found, install it? (y/n)%s ' ${COLOR_YELLOW} ${COLOR_RESET}
        read -r opt
        case ${opt} in
            y*|Y*|"") full_or_min ; exit 0
                ;;
            n*|N*) error "Installing cancelled." ; exit 0
                ;;
            *) error "Unkown flag <$@>"
                ;;
        esac
    fi
}

main "$@"
