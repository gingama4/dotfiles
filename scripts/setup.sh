#!/usr/bin/env bash

set -ue

REPO_DIR="$(cd "$(dirname "$0")/.."; pwd)"
CONFIGS_DIR="${REPO_DIR}/.config"

. "${CONFIGS_DIR}/zsh/zshenv.zsh"

. "${REPO_DIR}/scripts/common.sh"

setup_files="${REPO_DIR}/scripts/**/setup.sh"
for filepath in $setup_files; do
    . "$filepath"
done

setup_linux() {
    local distro
    distro=$(awk '{print $1; exit}' /etc/issue)
    title "Setting up ${distro}"

    setup_xdg_config
    setup_zsh
}

execute_setup() {
    setup_linux

    echo ""
    success "Setup is complete."
}

execute_setup
