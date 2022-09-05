#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck source=scripts/common.sh
source "${ROOT}/common.sh"

# Linux {{{
LINUX_TARGET="/tmp/update-golang"

check_shasum() {
    local url_sha="https://raw.githubusercontent.com/udhos/update-golang/master/update-golang.sh.sha256"

    wget -qO- "${LINUX_TARGET}/hash.txt" ${url_sha}

    (
        cd ${LINUX_TARGET}

        # shellcheck disable=SC2155
        local check=$(sha256sum -c "hash.txt")
        local msg_ok="update-golang.sh: OK"

        echo "${check}"

        if [[ ${check} != "${msg_ok}" ]]; then
            msg_cli red "Signature tempered!" normal
            exit 1
        fi
    )
}

# Install linux from update-golang
# https://github.com/udhos/update-golang
os_linux() {
    check_shasum

    (
        git clone https://github.com/udhos/update-golang ${LINUX_TARGET}
        cd ${LINUX_TARGET}
        sudo ./update-golang.sh
    )

    sudo rm /usr/local/*.tar.gz
}
# }}}

# MacOS {{{

os_macos() {
    if command_exists brew; then
        brew install go
    else
        msg_cli red "Homebrew not installed, install it first!" normal
    fi
}
# }}}

main() {
    if ! command_exists go; then
        msg_cli blue "Golang not installed, installing..." normal

        mkdir -p "${HOME}/go" # GOPATH

        if is_linux; then
            os_linux
        else
            os_macos
        fi
    else
        msg_cli yellow "Golang already installed at your system." normal
    fi
}

main
