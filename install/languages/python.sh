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
# Author: Serhat Teker <me@serhatteker.com>
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

# Default python version to install is 3.9
PYTHON_VERSION="${INSTALL_PYTHON_VERSION:-3.9}"
PYTHON="python${PYTHON_VERSION}"

# Install {{{

install_python_version() {
    if command_exists "${PYTHON}"; then
        info "You have already ${PYTHON} installed."
        return
    else
        msg "installing ${PYTHON}"
        brew install "python@${PYTHON_VERSION}"
    fi
}
# }}}

# Configure {{{

install_pip() {
    # 1. Export PYTHONPATH so python knows where Homebrew hid the packages
    local framework_path="$(brew --prefix "python@${PYTHON_VERSION}")/Frameworks/Python.framework/Versions/${PYTHON_VERSION}"

    # Force python to look in the Frameworks directory
    export PYTHONPATH="${framework_path}/lib/python${PYTHON_VERSION}/site-packages"

    # Also add the bin folder to PATH so 'pip' command works directly if needed
    export PATH="${framework_path}/bin:${PATH}"

    # 2. Run the pip checks
    # Ensure PIP_REQUIRE_VIRTUALENV is disabled for the bootstrap
    if ! PIP_REQUIRE_VIRTUALENV=false "${PYTHON}" -m pip --version > /dev/null 2>&1; then
        msg "pip module not found, installing"

        curl -sS https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py

        PIP_REQUIRE_VIRTUALENV=false \
            # "${PYTHON}" /tmp/get-pip.py --no-warn-script-location
            "${PYTHON}" /tmp/get-pip.py

        rm /tmp/get-pip.py
    else
        msg "pip already installed."
    fi

    # 3. Handle the version downgrade/upgrade
    # local current_pip_version=$(PIP_REQUIRE_VIRTUALENV=false "${PYTHON}" -m pip --version | awk '{print $2}')
    #
    # if [ "${current_pip_version}" != "${PIP_VERSION}" ]; then
    #      msg "Downgrading pip to ${PIP_VERSION}..."
    #      PIP_REQUIRE_VIRTUALENV=false "${PYTHON}" -m pip install "pip==${PIP_VERSION}"
    # fi
}

install_requirements() {
    PIP_REQUIRE_VIRTUALENV=false \
        "${PYTHON}" -m pip install --break-system-packages --user \
        -r "${ROOT}/python/requirements/base.txt"

    msg "Global user packages installed"
}

rich_traceback() {
    local site_dir="$(${PYTHON} -c "import site; print(f'{site.USER_SITE}')")"
    local file="${site_dir}/sitecustomize.py"

    cat <<EOF >>"${file}"
from rich.traceback import install
install(show_locals=True)
EOF

    msg "Rich traceback added"
}

configure_ipython() {
    local source="${DOTFILES}/python/ipython_config.py"
    local target="${XDG_CONFIG_HOME}/.ipython/profile_default"

    mkdir -p "${target}"
    ln -sf "${source}" "${target}"

    msg "ipython configured"
}
# }}}

main_configure() {
    msg "Python configuration started"
    install_pip
    install_requirements
    rich_traceback
    configure_ipython
}

main() {
    info "Python install started"
    install_python_version
    main_configure
    success "${PYTHON} installed and configured"
}

main
