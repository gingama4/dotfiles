#!/usr/bin/env bash

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
    local is_debug=${DOT_DEBUG:-false}
    if "${is_debug}"; then
      echo -e "${COLOR_RED}[DEBUG]${COLOR_GRAY}$1${COLOR_NONE}"
    fi
}

symlink() {
    echo -e "${COLOR_PURPLE}$1${COLOR_YELLOW} -----> ${COLOR_GREEN}$2${COLOR_NONE}"
    ln -snf "$1" "$2"
}

simple_link() {
    local target_dir=$1
    local target_func_name=${2:-$target_dir}
    title "Setting up ${target_func_name}"
    local target_file_dir="${CONFIGS_DIR}/${target_dir}"

    info "Creating symlink for ${target_func_name}"
    symlink "$target_file_dir" "${XDG_CONFIG_HOME}/${target_dir}"

    success "${target_func_name} complete"
}
