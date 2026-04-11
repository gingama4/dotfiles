#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ] ; then
  set -x
fi

readonly PACKAGE=(
  "build-essential"
  "procps"
  "curl"
  "file"
  "git"
)

function run_apt_get() {
  if ! command -v sudo > /dev/null 2>&1; then
    apt-get update
    apt-get install -y sudo
  fi

  sudo apt-get "$@"
}

function install_packages() {
  run_apt_get update
  run_apt_get install -y "${PACKAGE[@]}"
}

function main() {
  install_packages
}

main

