#!/bin/bash
set -e

setup_zsh() {
  title "Setting up zsh"
  local zsh_dot_dir="${DOT_DIR}/configs/zsh"
  symlink "${zsh_dot_dir}/zshenv.zsh" "${HOME}/.zshenv"
  symlink "${zsh_dot_dir}/rc" "${XDG_CONFIG_HOME}/zsh"

  info "Creating symlink for zsh"
  mkdir -p "${XDG_STATE_HOME}/zsh"

  success "zsh complete"
}
