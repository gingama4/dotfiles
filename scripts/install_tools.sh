#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ] ; then
  set -x
fi

readonly BREW_PACKAGES=(
  chezmoi
  cmake
  copilot-cli
  eza
  fzf
  git
  gh
  ghq
  gpg
  lazygit
  mise
  neovim
  ripgrep
  sheldon
  vim
  zsh
)

function is_brew_package_installed() {
  local package="$1"

  brew list "${package}" &> /dev/null
}

function install_brew_packages() {
  local missing_packages=()

  for package in "${BREW_PACKAGES[@]}"; do
    if ! is_brew_package_installed "${package}"; then
      missing_packages+=("${package}")
    fi
  done

  if [ "${#missing_packages[@]}" -gt 0 ]; then
    brew install "${missing_packages[@]}"
  fi
}

function main() {
  install_brew_packages
}

main

