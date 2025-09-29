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
	echo -e " \n${COLOR_GRAY}===========================================${COLOR_NONE}"
	echo -e " ${COLOR_PURPLE}$1${COLOR_NONE}"
	echo -e " ${COLOR_GRAY}-------------------------------------------${COLOR_NONE}"
}

error() {
	echo -e " ${COLOR_RED}Error: ${COLOR_NONE}$1"
	exit 1
}

warning() {
	echo -e " ${COLOR_YELLOW}Warning: ${COLOR_NONE}$1"
}

info() {
	echo -e " ${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}

success() {
	echo -e " ${COLOR_GREEN}$1${COLOR_NONE}"
}

debug() {
	local is_debug=${DOT_DEBUG:-0}
	if [[ "${is_debug}" -ne 0 ]]; then
		echo -e " ${COLOR_RED}[DEBUG]${COLOR_YELLOW}$1${COLOR_NONE}"
	fi
}

link() {
  local is_uninstall=${DOT_UNLINK:-0}
  if [[ "${is_uninstall}" -ne 0 ]]; then
    safe_unlink "$2"
  else
    safe_link "$1" "$2"
  fi
}

safe_link() {
  local is_dry_run=${DOT_DRY_RUN:-0}

  local src="$1"
  local dest="$2"

  # 親ディレクトリを取得
  local parent_dir="$(dirname "$dest")"

  # 親ディレクトリがなければ作成
  if [ ! -d "$parent_dir" ]; then
    if [[ "${is_dry_run}" -ne 0 ]]; then
      echo -e " ${COLOR_BLUE}Creating parent directory: ${COLOR_GREEN}$parent_dir ${COLOR_GRAY}(dry-run)${COLOR_NONE}"
    else
      echo -e " ${COLOR_BLUE}Creating parent directory: ${COLOR_GREEN}$parent_dir${COLOR_NONE}"
      mkdir -p "$parent_dir"
    fi
  fi

  # 既にリンク先が存在する場合のチェック
  if [ -L "$dest" ]; then
    # 既に正しいリンクなら何もしない
    if [ "$(readlink "$dest")" = "$src" ]; then
      echo -e " ${COLOR_BLUE}Symlink already exists and is correct: ${COLOR_GREEN}$dest${COLOR_NONE}"
      exit 0
    else
      echo -e " ${COLOR_YELLOW}Symlink exists but points elsewhere: ${COLOR_GREEN}$dest${COLOR_NONE}"
      if [[ "${is_dry_run}" -eq 0 ]]; then
        exit 1
      fi
    fi
  elif [ -e "$dest" ]; then
    echo -e " ${COLOR_RED}File or directory already exists at ${COLOR_PURPLE}$dest${COLOR_RED}. Please removed.${COLOR_NONE}"
    if [[ "${is_dry_run}" -eq 0 ]]; then
      exit 1
    fi
  fi

  # シンボリックリンク作成
  if [[ "${is_dry_run}" -ne 0 ]]; then
    echo -e " ${COLOR_PURPLE}$1${COLOR_YELLOW} -----> ${COLOR_GREEN}$2 ${COLOR_GRAY}(dry-run)${COLOR_NONE}"
  else
    echo -e " ${COLOR_PURPLE}$1${COLOR_YELLOW} -----> ${COLOR_GREEN}$2${COLOR_NONE}"
    ln -s "$src" "$dest"
  fi
}

safe_unlink() {
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

symlink() {
  link "$1" "$2"
}

