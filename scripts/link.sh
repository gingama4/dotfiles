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

function link() {
  local is_uninstall=${DOT_UNLINK:-0}
  if [[ "${is_uninstall}" -ne 0 ]]; then
    safe_unlink "$2"
  else
    safe_link "$1" "$2"
  fi
}

function safe_link() {
  local is_dry_run=${DOT_DRY_RUN:-0}

  local src="$1"
  local dest="$2"

  local parent_dir="$(dirname "$dest")"

  if [ ! -d "$parent_dir" ]; then
    if [[ "${is_dry_run}" -ne 0 ]]; then
      echo -e " ${COLOR_BLUE}Creating parent directory: ${COLOR_GREEN}$parent_dir ${COLOR_GRAY}(dry-run)${COLOR_NONE}"
    else
      echo -e " ${COLOR_BLUE}Creating parent directory: ${COLOR_GREEN}$parent_dir${COLOR_NONE}"
      mkdir -p "$parent_dir"
    fi
  fi

  # Check if destination exists
  if [ -L "$dest" ]; then
    # Already a symlink, check if it points to the correct source
    if [ "$(readlink "$dest")" = "$src" ]; then
      echo -e " ${COLOR_BLUE}Symlink already exists and is correct: ${COLOR_GREEN}$dest${COLOR_NONE}"
      return 0
    else
      echo -e " ${COLOR_YELLOW}Symlink exists but points elsewhere: ${COLOR_GREEN}$dest${COLOR_NONE}"
      if [[ "${is_dry_run}" -eq 0 ]]; then
        return 1
      fi
    fi
  elif [ -e "$dest" ]; then
    echo -e " ${COLOR_RED}File or directory already exists at ${COLOR_PURPLE}$dest${COLOR_RED}. Please removed.${COLOR_NONE}"
    if [[ "${is_dry_run}" -eq 0 ]]; then
      return 1
    fi
  fi

  # Create the symlink
  if [[ "${is_dry_run}" -ne 0 ]]; then
    echo -e " ${COLOR_PURPLE}$1${COLOR_YELLOW} -----> ${COLOR_GREEN}$2 ${COLOR_GRAY}(dry-run)${COLOR_NONE}"
  else
    echo -e " ${COLOR_PURPLE}$1${COLOR_YELLOW} -----> ${COLOR_GREEN}$2${COLOR_NONE}"
    ln -s "$src" "$dest"
  fi
}

function safe_unlink() {
  local is_dry_run=${DOT_DRY_RUN:-0}
  local dest="$1"
  if [ -L "$dest" ]; then
    if [[ "${is_dry_run}" -ne 0 ]]; then
      echo -e " ${COLOR_PURPLE}$dest${COLOR_YELLOW} <----- ${COLOR_RED}removed ${COLOR_GRAY}(dry-run)${COLOR_NONE}"
    else
      echo -e " ${COLOR_PURPLE}$dest${COLOR_YELLOW} <----- ${COLOR_RED}removed${COLOR_NONE}"
      unlink "$dest"
    fi
  else
    echo -e " ${COLOR_YELLOW}No symlink found at ${COLOR_PURPLE}$dest${COLOR_YELLOW}, skipping.${COLOR_NONE}"
  fi
}

function symlink() {
  link "$1" "$2"
}

function safe_copy() {
  local is_dry_run=${DOT_DRY_RUN:-0}

  local src="$1"
  local dest="$2"

  local parent_dir="$(dirname "$dest")"

  if [ ! -d "$parent_dir" ]; then
    if [[ "${is_dry_run}" -ne 0 ]]; then
      echo -e " ${COLOR_BLUE}Creating parent directory: ${COLOR_GREEN}$parent_dir ${COLOR_GRAY}(dry-run)${COLOR_NONE}"
    else
      echo -e " ${COLOR_BLUE}Creating parent directory: ${COLOR_GREEN}$parent_dir${COLOR_NONE}"
      mkdir -p "$parent_dir"
    fi
  fi

  # Copy the file 
  if [[ "${is_dry_run}" -ne 0 ]]; then
    echo -e " COPY: ${COLOR_PURPLE}$1${COLOR_YELLOW} -----> ${COLOR_GREEN}$2 ${COLOR_GRAY}(dry-run)${COLOR_NONE}"
  else
    echo -e " COPY: ${COLOR_PURPLE}$1${COLOR_YELLOW} -----> ${COLOR_GREEN}$2${COLOR_NONE}"
    cp "$src" "$dest"
  fi
}

load_scripts
setup_zsh
setup_git
setup_nvim
setup_wezterm
setup_tmux
