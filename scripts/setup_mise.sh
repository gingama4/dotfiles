#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ] ; then
  set -x
fi

function activate_mise() {
  eval "$(mise activate bash)"
}

function run_mise_install() {
  mise install
}

function main() {
  activate_mise
  run_mise_install
}

main
