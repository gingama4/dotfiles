#!/bin/bash
set -e

setup_wezterm() {
  title "Setting up wezterm"
  local wez_dot_dir="${DOT_DIR}/configs/wezterm"
  symlink "${wez_dot_dir}" "${XDG_CONFIG_HOME}/wezterm"

  success "wezterm complete"
}
