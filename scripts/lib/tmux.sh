#!/bin/bash
set -e

setup_tmux() {
  title "Setting up tmux"
  local wez_dot_dir="${DOT_DIR}/configs/tmux"
  symlink "${wez_dot_dir}" "${XDG_CONFIG_HOME}/tmux"

  success "tmux complete"
}
