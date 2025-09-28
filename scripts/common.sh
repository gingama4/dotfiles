#!/bin/bash
set -e

COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"

title() {
	echo -e "\n${COLOR_GRAY}===========================================${COLOR_NONE}"
	echo -e "${COLOR_PURPLE}$1${COLOR_NONE}"
	echo -e "${COLOR_GRAY}-------------------------------------------${COLOR_NONE}"
}

error() {
	echo -e "${COLOR_RED}Error: ${COLOR_NONE}$1"
	exit 1
}

warning() {
	echo -e "${COLOR_YELLOW}Warning: ${COLOR_NONE}$1"
}

info() {
	echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}

success() {
	echo -e "${COLOR_GREEN}$1${COLOR_NONE}"
}

debug() {
	local is_debug=${DOT_DEBUG:-0}
	if [[ "${is_debug}" -ne 0 ]]; then
		echo -e "${COLOR_RED}[DEBUG]${COLOR_YELLOW}$1${COLOR_NONE}"
	fi
}

link() {
  local is_dry_run=${DOT_DRY_RUN:-0}
  local is_uninstall=${DOT_UNLINK:-0}
  if [[ "${is_dry_run}" -ne 0 ]]; then
    echo -e "${COLOR_PURPLE}$1${COLOR_YELLOW} -----> ${COLOR_GREEN}$2${COLOR_NONE} (dry-run)"
  elif [[ "${is_uninstall}" -ne 0 ]]; then
    echo -e "${COLOR_PURPLE}$2${COLOR_YELLOW} <----- ${COLOR_RED}removed${COLOR_NONE}"
    unlink "$2"
  else
    echo -e "${COLOR_PURPLE}$1${COLOR_YELLOW} -----> ${COLOR_GREEN}$2${COLOR_NONE}"
    mkdir -p "$(dirname "$2")"
    ln -snf "$1" "$2"
  fi
}

symlink() {
  link "$1" "$2"
}

