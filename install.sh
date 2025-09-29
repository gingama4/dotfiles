#!/bin/bash
set -e

# Options
while [[ "$1" == -* ]]; do
  case "$1" in
    -d|--dry-run)
      DOT_DRY_RUN=1
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

DOT_DIR="${DOT_DIR:-$HOME/dotfiles}"
REPO_URL="https://github.com/gingama4/dotfiles"

DIALOG="
  author: gingama4
  repository: $REPO_URL

  Select:
  [a] all above
  [d] download dotfiles
  [l] link dotfiles
  [u] unlink dotfiles
  [q] quit
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
if [[ "$DOT_DRY_RUN" -ne 0 ]]; then
  echo "  dry-run mode enabled."
fi

read -r selection

if [[ "$selection" = *"q"* ]]; then
  exit 0
fi

if [[ "$selection" = *"a"* ]] || [[ "$selection" = *"d"* ]]; then
  echo "  begin download dotfiles."
  download_dotfiles
  echo "  end download dotfiles."
fi

if [[ "$selection" = *"a"* ]] || [[ "$selection" = *"l"* ]] || [[ "$selection" = *"u"* ]]; then
  if [[ "$selection" = *"u"* ]]; then
    DOT_UNLINK=1
    echo "  begin unlink dotfiles."
  else
    echo "  begin link dotfiles."
  fi
  link_dotfiles
  echo "  end link dotfiles."
fi

echo "  finished."
