#!/usr/bin/env bash

set -ue

setup_zsh() {
    title "Setting up zsh"
    local zsh_file_dir="${CONFIGS_DIR}/zsh"

    info "Creating symlink for zsh"
    symlink "${zsh_file_dir}/zshenv.zsh" "${HOME}/.zshenv"
    symlink "$zsh_file_dir" "${XDG_CONFIG_HOME}/zsh"

    info "Creating zsh history dir"
    mkdir -p "${XDG_STATE_HOME}/zsh"

    success "zsh complete"
}
