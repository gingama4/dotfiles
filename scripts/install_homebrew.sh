#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ] ; then
  set -x
fi

function install_homebrew() {
  function is_homebrew_installed() {
    command -v brew &> /dev/null
  }

  if ! is_homebrew_installed; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

function opt_out_of_analytics() {
  brew analytics off
}

function main() {
  install_homebrew
  opt_out_of_analytics
}

main

