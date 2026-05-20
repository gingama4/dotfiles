#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
  set -x
fi

readonly SOURCE_DIR="${DOTFILES_SOURCE_DIR:-/workspace/dotfiles}"
readonly TEST_HOME="${HOME}"
readonly CHEZMOI_SOURCE="${TEST_HOME}/.local/share/chezmoi"

function activate_nix() {
  if [ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
    # shellcheck disable=SC1091
    . "${HOME}/.nix-profile/etc/profile.d/nix.sh"
  fi
}

function prepare_source() {
  rm -rf "${CHEZMOI_SOURCE}"
  mkdir -p "$(dirname "${CHEZMOI_SOURCE}")"
  cp -a "${SOURCE_DIR}" "${CHEZMOI_SOURCE}"

  # Local path flakes only include files known to Git. In this Docker test the
  # source may contain uncommitted changes, so make the copy a throwaway repo.
  git -C "${CHEZMOI_SOURCE}" init -q
  git -C "${CHEZMOI_SOURCE}" add -A
}

function prepare_chezmoi_config() {
  mkdir -p "${HOME}/.config/chezmoi"
  cat > "${HOME}/.config/chezmoi/chezmoi.toml" <<'EOF'
[data.git.user]
    name = "gingama4"
    email = "me@gingama4.com"
EOF
}

function render_scripts() {
  chezmoi --source "${CHEZMOI_SOURCE}" execute-template \
    --file "${CHEZMOI_SOURCE}/home/.chezmoiscripts/run_once_before_02-install-nix.sh.tmpl" \
    > /tmp/install-nix.sh
  bash -n /tmp/install-nix.sh

  chezmoi --source "${CHEZMOI_SOURCE}" execute-template \
    --file "${CHEZMOI_SOURCE}/home/.chezmoiscripts/run_onchange_after_01-apply-nix.sh.tmpl" \
    > /tmp/apply-nix.sh
  bash -n /tmp/apply-nix.sh
}

function install_nix() {
  /usr/local/bin/install-nix
  activate_nix
}

function build_home_manager() {
  nix --extra-experimental-features "nix-command flakes" build \
    "${CHEZMOI_SOURCE}#homeConfigurations.wsl.activationPackage" \
    --out-link /tmp/dotfiles-home-manager
}

function apply_chezmoi() {
  DOTFILES_SKIP_NIX_INSTALL=1 chezmoi --source "${CHEZMOI_SOURCE}" apply --force
}

function smoke_test() {
  activate_nix

  command -v home-manager
  command -v mise
  command -v nvim
  command -v node
  command -v git
  test -f "${HOME}/.config/zsh/.zprofile"
  test -f "${HOME}/.config/mise/config.toml"
}

function main() {
  prepare_source
  prepare_chezmoi_config
  render_scripts
  install_nix
  build_home_manager
  apply_chezmoi
  smoke_test
}

main
