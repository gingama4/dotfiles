#!/usr/bin/env bash

set -ue

setup_nvim() {
    title "Setting up Neovim"
    local nvim_file_dir="${CONFIGS_DIR}/nvim"

    info "Creating symlink for Neovim"
    symlink "$nvim_file_dir" "${XDG_CONFIG_HOME}/nvim"

    success "Neovim complete"
}

