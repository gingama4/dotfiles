#!/usr/bin/env bash

set -ue

REPO_DIR="$(cd "$(dirname "$0")/.."; pwd)"
CONFIGS_DIR="${REPO_DIR}/.config"

. "${CONFIGS_DIR}/zsh/zshenv.zsh"

. "${REPO_DIR}/scripts/common.sh"

debug $REPO_DIR
debug $CONFIGS_DIR

scripts_dir="${REPO_DIR}/scripts"

debug $scripts_dir

setup_files="${scripts_dir}/**/setup.sh"

debug "------ Load Scripts: Start -------"
for filepath in $setup_files; do
    debug $filepath
    . "$filepath"
done
debug "------ Load Scripts: End -------"

setup_linux() {
    local distro
    distro=$(awk '{print $1; exit}' /etc/issue)
    title "Setting up ${distro}"

    setup_cui
    setup_gui
}

setup_cui() {
    setup_xdg_config
    setup_zsh
    setup_git
    setup_nvim
}

setup_gui() {
    setup_i3
    setup_polybar
}

execute_setup() {
    setup_linux

    echo ""
    success "Setup is complete."
}

execute_setup
