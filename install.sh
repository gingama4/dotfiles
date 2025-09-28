#!/bin/bash
set -e

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

DOT_DIR="${DOT_DIR:-$HOME/dotfiles}"
REPO_URL="https://github.com/gingama4/dotfiles"

DIALOG="
  author: gingama4
  repository: $REPO_URL
"

has() {
  type "$1" > /dev/null 2>&1
}
die() {
  echo "$1"
  echo "  terminated."
  exit 1
}
die_if_error() {
  if [ $? -ne 0 ]; then
    die "Error occurred during $1"
  fi
}

download_dotfiles() {
  if [ -d "$DOT_DIR" ]; then
    echo "$DOT_DIR is already exists."
  else
    if has "git"; then
      git clone --recursive "$REPO_URL" "$DOT_DIR"
      die_if_error "git clone"
    else
      die "cannot download dotfiles."
    fi
  fi
}

link_dotfiles() {
  source "${DOT_DIR}/scripts/link.sh"
}

# Main Process
echo "dotfiles" "$DIALOG"

# Step 1: Download dotfiles
echo "  begin download dotfiles."
download_dotfiles
echo "  end download dotfiles."

# Step 2: Link dotfiles
echo "  begin link dotfiles."
link_dotfiles
echo "  end link dotfiles."

echo "  finished."
