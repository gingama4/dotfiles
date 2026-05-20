#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
  set -x
fi

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
readonly WORK_DIR="${RUNNER_TEMP:-${TMPDIR:-/tmp}}/dotfiles-macos-test"
readonly OUT_LINK="${WORK_DIR}/dotfiles-darwin-system"
readonly NIX_FLAKE_FLAGS=(--extra-experimental-features "nix-command flakes" --no-write-lock-file)

function nix_command() {
  if command -v nix > /dev/null 2>&1; then
    command -v nix
    return
  fi

  if [ -x /nix/var/nix/profiles/default/bin/nix ]; then
    printf '%s\n' /nix/var/nix/profiles/default/bin/nix
    return
  fi

  echo "nix command not found. Install Nix before running this test." >&2
  exit 1
}

function activate_nix() {
  if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
    # shellcheck disable=SC1091
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  elif [ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
    # shellcheck disable=SC1091
    . "${HOME}/.nix-profile/etc/profile.d/nix.sh"
  fi
}

function run_chezmoi() {
  if command -v chezmoi > /dev/null 2>&1; then
    chezmoi "$@"
    return
  fi

  local nix_bin
  nix_bin="$(nix_command)"
  "${nix_bin}" "${NIX_FLAKE_FLAGS[@]}" shell nixpkgs#chezmoi -c chezmoi "$@"
}

function prepare_work_dir() {
  rm -rf "${WORK_DIR}"
  mkdir -p "${WORK_DIR}"
}

function render_script() {
  local source_path="$1"
  local output_path="$2"

  run_chezmoi --source "${ROOT_DIR}" execute-template \
    --file "${ROOT_DIR}/${source_path}" \
    > "${output_path}"
  bash -n "${output_path}"
}

function render_scripts() {
  render_script "home/.chezmoiscripts/run_once_before_01-macos-prepare-system.sh.tmpl" \
    "${WORK_DIR}/macos-prepare-system.sh"
  render_script "home/.chezmoiscripts/run_once_before_02-install-nix.sh.tmpl" \
    "${WORK_DIR}/install-nix.sh"
  render_script "home/.chezmoiscripts/run_onchange_after_01-apply-nix.sh.tmpl" \
    "${WORK_DIR}/apply-nix.sh"
}

function build_darwin_system() {
  local nix_bin
  nix_bin="$(nix_command)"

  "${nix_bin}" "${NIX_FLAKE_FLAGS[@]}" build \
    "${ROOT_DIR}#darwinConfigurations.hades.system" \
    --out-link "${OUT_LINK}"

  test -x "${OUT_LINK}/sw/bin/darwin-rebuild"
}

function main() {
  activate_nix
  prepare_work_dir
  render_scripts
  build_darwin_system
}

main
