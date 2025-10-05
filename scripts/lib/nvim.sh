#!/bin/bash
set -e

setup_nvim() {
  title "Setting up nvim"
  local nvim_dot_dir="${DOT_DIR}/configs/nvim"
  symlink "${nvim_dot_dir}" "${XDG_CONFIG_HOME}/nvim"

  success "nvim complete"
}

