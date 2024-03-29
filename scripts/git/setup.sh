#!/usr/bin/env bash

set -ue

setup_git() {
    title "Setting up Git"
    local git_file_dir="${CONFIGS_DIR}/git"
    local git_config_dir="${XDG_CONFIG_HOME}/git"

    if [ -d "$git_config_dir" ]; then
      info "Already exists config file."
    else
      info "Creating git config file"
      mkdir -p "$git_config_dir"
      touch "${git_config_dir}/config"
    fi

    info "Setting up git"
    git config --global pull.rebase false

    git config --global init.defaultBranch main

    git config --global fetch.prune true

    git config --global core.ignorecase false

    git config --global commit.gpgsign true
    git config --global gpg.format ssh

    git config --global merge.conflictstyle diff3

    git config --global diff.colorMoved default

    success "Git complete"
}
