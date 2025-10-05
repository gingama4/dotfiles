#!/bin/bash
set -e

setup_git() {
  title "Setting up git"
  local git_dot_dir="${DOT_DIR}/configs/git"
  local git_config_dir="${XDG_CONFIG_HOME}/git"
  mkdir -p "${git_config_dir}"
  symlink "${git_dot_dir}/config" "${git_config_dir}/config"

  info "Creating ~/.gitconfig.local"
  touch "${HOME}/.gitconfig.local"

  success "git complete"
}

