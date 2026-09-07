#!/usr/bin/env bash
set -e

DOT_DIR="${DOT_DIR:-${HOME}/dotfiles}"
REPO_URL="https://github.com/gingama4/dotfiles"
DIALOG="
 Setup Steps:
 (1) download dotfiles
 (2) setup nix-darwin
 (3) setup home-manager

 Select:
 [a] run all steps
 [1-3] run a specific step
 * You can use multiple choose like '23'
"

main () {
  echo " Dotfiles by gingama4"
  OS="$(uname)"

  if [ "$OS" != "Darwin" ]; then
    echo "  --> Unsupported OS: ${OS}"
    exit 1
  fi

  local selected_steps
  if [ -t 0 ]; then
    echo "$DIALOG"
    read -r selected_steps
  else
    selected_steps="a"
  fi

  echo "  --> Starting setup script..."

  ensure_nix

  if [[ "$selected_steps" = *"a"* ]] || [[ "$selected_steps" = *"1"* ]]; then
    download_dotfiles
  fi

  if [[ "$selected_steps" = *"a"* ]] || [[ "$selected_steps" = *"2"* ]]; then
    setup_darwin
  fi

  if [[ "$selected_steps" = *"a"* ]] || [[ "$selected_steps" = *"3"* ]]; then
    setup_home
  fi
  echo "  --> Finished."
}

ensure_nix() {
  has nix && return
  echo "  --> Installing nix (Lix installer)..."
  curl -sSf -L https://install.lix.systems/lix | sh -s -- install --no-confirm
  nix_profile="/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
  [ -e "$nix_profile" ] && . "$nix_profile"
}

download_dotfiles() {
  if [ -d "$DOT_DIR" ]; then
    echo "  --> Dotfiles already exist at ${DOT_DIR}"
  else
    echo "  --> Cloning dotfiles from ${REPO_URL} to ${DOT_DIR}"
    git_cmd clone "$REPO_URL" "$DOT_DIR"
  fi
}

git_cmd() {
  if has git; then
    git "$@"
  else
    nix --extra-experimental-features "nix-command flakes" run nixpkgs#git -- "$@"
  fi
}

setup_darwin() {
  echo "  --> Setting up nix-darwin..."
  darwin_cmd switch --flake "$DOT_DIR"#hades
}

darwin_cmd() {
  if has darwin-rebuild; then
    sudo darwin-rebuild "$@"
  else
    sudo nix --extra-experimental-features "nix-command flakes" run \
      --inputs-from "$DOT_DIR" \
      nix-darwin#darwin-rebuild -- "$@"
  fi
}

setup_home() {
  echo "  --> Setting up home-manager..."
  homemanager_cmd switch --flake "$DOT_DIR"#normal
}

homemanager_cmd() {
  if has home-manager; then
    home-manager "$@"
  else
    nix --extra-experimental-features "nix-command flakes" run \
      --inputs-from "$DOT_DIR" \
      home-manager#home-manager -- "$@"
  fi
}

has () {
  type "$1" > /dev/null 2>&1
}

main
