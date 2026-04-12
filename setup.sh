#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ] ; then
  set -x
fi

declare -r DOTFILES_REPO_URL="https://github.com/gingama4/dotfiles"

declare -r DOTFILES_DIALOG='
DOTFILES
author: gingama4
repository: https://github.com/gingama4/dotfiles
'

declare -r OS_TYPE="$(uname -s)"

function initialize_dotfiles() {
  run_chezmoi
}

function run_chezmoi() {
  local bin_dir="${HOME}/.local/bin"
  export PATH="${PATH}:${bin_dir}"

  # Download chezmoi binary
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "${bin_dir}"
  local chezmoi_cmd="${bin_dir}/chezmoi"

  command -v "${chezmoi_cmd}" &> /dev/null || {
    echo "Error: chezmoi command not found after installation." >&2
    exit 1
  }

  # Run chezmoi init
  "${chezmoi_cmd}" init "${DOTFILES_REPO_URL}"

  # Purge the binary og the chezmoi
  rm -fv "${chezmoi_cmd}"
}

function main() {
  echo "${DOTFILES_DIALOG}"

  initialize_dotfiles
}

main
