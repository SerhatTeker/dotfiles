#!/usr/bin/env bash
# ----------------------------------------------------------------------------#
#                               _                 _
#                        __   _(_)_ __ ___    ___| |__
#                        \ \ / / | '_ ` _ \  / __| '_ \
#                         \ V /| | | | | | |_\__ \ | | |
#                          \_/ |_|_| |_| |_(_)___/_| |_|
#

# Author: Serhat Teker <serhat.teker@gmail.com>
# Source: https://github.com/SerhatTeker/dotfiles
#
# Install and customize vim
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


python-requirements() {
    PIP_REQUIRE_VIRTUALENV=false \
        python${PYTHON_VERSION} -m pip install --user \
        -r ${DOTFILES}/python/requirements/base.txt
}


sf-mono-powerline() {
    bash ${ROOT}/install/sf-fonts.sh
}

main() {
    python-requirements
    sf-mono-powerline
}

main

exit 0
