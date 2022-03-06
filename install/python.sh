#!/usr/bin/env bash
# ----------------------------------------------------------------------------#
#                      _           _        _ _       _
#                     (_)_ __  ___| |_ __ _| | |  ___| |__
#                     | | '_ \/ __| __/ _` | | | / __| '_ \
#                     | | | | \__ \ || (_| | | |_\__ \ | | |
#                     |_|_| |_|___/\__\__,_|_|_(_)___/_| |_|
#
# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# ----------------------------------------------------------------------------#
#
# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail

# Locate the root directory
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# shellcheck source=scripts/common.sh
source "${ROOT}/install/common.sh"


VERSION=${PYTHON_VERSION:-3.8}
PYTHON="python${VERSION}"

# Install {{{


install_packages() {
    # Can't use ensurepip cause it's disabled for Ubuntu
    # ${PYTHON} -m ensurepip --upgrade
    # https://pip.pypa.io/en/stable/installation/#ensurepip
    if is_linux; then
        sudo apt update -y
        sudo apt install -y \
            python3-pip \
            ${PYTHON}-venv
    fi
}

install_reqirements() {
    PIP_REQUIRE_VIRTUALENV=false \
        ${PYTHON} -m pip install --user \
        -r "${ROOT}/python/requirements/base.txt"

    msg_cli blue "Global user packages installed"
}

_install() {
    install_packages
    install_reqirements
}
# }}}

# Configure {{{

pretty_errors() {
    local site_dir="$(${PYTHON} -c "import site; print(f'{site.USER_SITE}')")"

    ln -sf "${ROOT}/python/usercustomize.py" \
        ${site_dir}

    msg_cli white "Pretty errors configuration added"
}

rich_traceback() {
    local site_dir="$(${PYTHON} -c "import site; print(f'{site.USER_SITE}')")"
    local file="${site_dir}/sitecustomize.py"

    cat << EOF >> ${file}
from rich.traceback import install
install(show_locals=True)
EOF
    msg_cli white "Rich traceback added"
}

configure_pudb() {
    mkdir -p ${XDG_CONFIG_HOME}/pudb
    ln -sf "${ROOT}/python/pudb.cfg" \
        ${XDG_CONFIG_HOME}/pudb

    msg_cli white "pudb configured"
}

_configure() {
    pretty_errors
    rich_traceback
    configure_pudb
}
# }}}

main() {
    _install
    _configure

    msg_cli green "Python configured"
}

main
# _configure

exit 0
