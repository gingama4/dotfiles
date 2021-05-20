#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/util.sh

function _link() {
  local link_src_file=$1
  local link_dest_dir=$2
  local f_filename
  f_filename=$(basename "$link_src_file")
  local f_filepath="$link_dest_dir/$f_filename"
  if [[ -L "$f_filepath" ]]; then
    command rm -f "$f_filepath"
  fi
  print_default "Creating symlink for $link_src_file -> $link_dest_dir"
  command ln -snf "$link_src_file" "$link_dest_dir"
}

function link_vimdir() {
  local vim_dir
  vim_dir="$HOME/.vim"
  local config_dir
  config_dir="$vim_dir/config"
  mkdir_not_exist $config_dir
  local current_dir
  current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
  local dotfiles_dir
  dotfiles_dir="$(builtin cd "$current_dir" && git rev-parse --show-toplevel)"
  local vimdot_dir
  vimdot_dir="$dotfiles_dir/vim"
  if [[ "$HOME" != "$vimdot_dir" ]]; then
    for f in "$vimdot_dir"/??*; do
      local f_filename
      f_filename=$(basename "$f")
      [[ "$f_filename" == "vimrc" ]] && _link "$f" "$HOME/.vimrc" && continue
      _link "$f" "$config_dir"
    done
  fi
  _link "$config_dir" "$HOME/.config/nvim/config"
}

link_vimdir
