#!/usr/bin/env bash

# Bash safeties: exit on error, no unset variables, pipelines can't hide errors
set -o errexit
set -o nounset
set -o pipefail


# SF Mono {{{

cd /tmp && \
	git clone https://github.com/Twixes/SF-Mono-Powerline.git --depth=1

cd /tmp/SF-Mono-Powerline

# Set source and target directories
powerline_fonts_dir="$( cd "$( dirname "$0" )" && pwd )"

# if an argument is given it is used to select which fonts to install
prefix=""

if test "$(uname)" = "Darwin" ; then
  # MacOS
  font_dir="$HOME/Library/Fonts"
else
  # Linux
  font_dir="$HOME/.local/share/fonts"
  mkdir -p $font_dir
fi

# Copy all fonts to user fonts directory
echo "Copying fonts..."
find "$powerline_fonts_dir" \( -name "$prefix*.[ot]tf" -or -name "$prefix*.pcf.gz" \) -type f -print0 | xargs -0 -n1 -I % cp "%" "$font_dir/"

# Reset font cache on Linux
if which fc-cache >/dev/null 2>&1 ; then
    echo "Resetting font cache, this may take a moment..."
    fc-cache -f "$font_dir"
fi

echo "SF-Mono-Powerline fonts installed to $font_dir"
# }}}


# Powerline Patched {{{

cd /tmp && \
    git clone https://github.com/powerline/fonts.git --depth=1

cd /tmp/fonts && \
    ./install.sh
# }}}
