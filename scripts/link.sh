#!/bin/bash
set -e

CONFIGS_DIR="${DOT_DIR}/configs"

function load_scripts() {
  source "${DOT_DIR}/scripts/common.sh"

  local setup_files="${DOT_DIR}/scripts/lib/*.sh"
  for filepath in $setup_files; do
    source "$filepath"
  done
}

load_scripts
setup_zsh
