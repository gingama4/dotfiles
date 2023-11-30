#!/usr/bin/env bash

set -ue

INSTALL_DIR="${INSTALL_DIR:-$HOME/ghq/github.com/gingama4/dotfiles}"
CI=${CI:-0}

if [ $CI -ne 1 ]; then
    if [ -d "$INSTALL_DIR" ]; then
        echo "Updating dotfiles..."
        git -C "$INSTALL_DIR" pull
    else
        echo "Installing dotfiles..."
        git clone https://github.com/gingama4/dotfiles "$INSTALL_DIR"
    fi
fi

/usr/bin/env bash "$INSTALL_DIR/scripts/setup.sh" "$@"
