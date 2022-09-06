#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# vim: set ft=sh et ts=4 sw=4 sts=4:
# ----------------------------------------------------------------------------#
#                             _   _                       _
#                 _ __  _   _| |_| |__   ___  _ __    ___| |__
#                | '_ \| | | | __| '_ \ / _ \| '_ \  / __| '_ \
#                | |_) | |_| | |_| | | | (_) | | | |_\__ \ | | |
#                | .__/ \__, |\__|_| |_|\___/|_| |_(_)___/_| |_|
#                |_|    |___/
#
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Install desired python version and related packages and configure dev tools
# ----------------------------------------------------------------------------#

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=1091
source "${ROOT}/common.sh"

# Use 3.9 as default python version
VERSION=${PYTHON_VERSION:-3.9}
PYTHON="python${VERSION}"

# New python installation version
_INSTALL_PYTHON_VERSION=${INSTALL_PYTHON_VERSION:-3.9.13}
# INSTALL_URL="https://git.io/JLQFl" # WARNING: Github deprecated git.io
INSTALL_URL="https://gist.githubusercontent.com/SerhatTeker/7d0fc99d27e9bf1d75b4435a38a89fe9/raw/install-python"

# Install {{{

# TODO: Run it manually on full.sh
install_specific_python_version() {
    if command_exists "${PYTHON}"; then
        info "You have already ${PYTHON}"
        return
    fi

    if is_macos; then
        # Installing on MacOS complicated
        error "You should install ${PYTHON} on MacOS manually!"
        exit 1
    else
        INSTALL_PYTHON_VERSION="${_INSTALL_PYTHON_VERSION}" \
            wget -O - ${INSTALL_URL} | bash

        success "Python installed!"
        "${PYTHON}" --version --version
    fi
}

check_python3() {
    # NOTE: Use default python3 on the OS.
    # Skip the function if $PYTHON_VERSION already exists
    if command_exists python3; then
        info "You have already ${PYTHON}"
        return
    fi

    if is_macos; then
        # Installing on MacOS complicated
        error "You should install python3 on MacOS manually!"
        exit 1
    fi
}

install_packages() {
    # Can't use ensurepip cause it's disabled for Ubuntu
    # ${PYTHON} -m ensurepip --upgrade
    # https://pip.pypa.io/en/stable/installation/#ensurepip
    if is_linux; then
        sudo apt update -y
        sudo apt install -y \
            python3-pip \
            python3-venv
        info "Python Linux packages installed"
    fi
}

install_reqirements() {
    PIP_REQUIRE_VIRTUALENV=false \
        ${PYTHON} -m pip install --user \
        -r "${ROOT}/python/requirements/base.txt"

    success "Global user packages installed"
}

main_install() {
    info "Python install started"
    check_python3
    install_packages
    install_reqirements
}
# }}}

# Configure {{{

# Disable: use rich
pretty_errors() {
    local site_dir="$(${PYTHON} -c "import site; print(f'{site.USER_SITE}')")"
    ln -sf "${ROOT}/python/usercustomize.py" "${site_dir}"
    msg_cli white "Pretty errors configuration added"
}

rich_traceback() {
    local site_dir="$(${PYTHON} -c "import site; print(f'{site.USER_SITE}')")"
    local file="${site_dir}/sitecustomize.py"

    cat <<EOF >>"${file}"
from rich.traceback import install
install(show_locals=True)
EOF

    msg_cli white "Rich traceback added" normal
}

configure_pudb() {
    local source="${DOTFILES}/python/pudb.cfg"
    local target="${XDG_CONFIG_HOME}/pudb"

    mkdir -p "${target}"
    ln -sf "${source}" "${target}"

    msg_cli white "pudb configured" normal
}

configure_ipython() {
    local source="${DOTFILES}/python/ipython_config.py"
    local target="${XDG_CONFIG_HOME}/.ipython/profile_default"

    mkdir -p "${target}"
    ln -sf "${source}" "${target}"

    msg_cli white "ipython configured" normal
}

main_configure() {
    info "Python configuration started"
    rich_traceback
    configure_pudb
    configure_ipython
    success "Python3 configured"
}
# }}}

main() {
    main_install
    main_configure
}

main "${@}"
