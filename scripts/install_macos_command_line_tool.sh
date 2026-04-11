#!/usr/bin/env bash

set -Eeuo pipefail

function install_command_line_tool() {
  local xcode_git_path="/Library/Developer/CommandLineTools/usr/bin/git"

  if [ -e "${xcode_git_path}" ]; then
    echo "Command Line Tools are already installed."
    return 0
  fi

  xcode-select --install || true

  local -i waited=0
  local -i timeout=300 # 5 minutes
  while [ ! -e "${xcode_git_path}" ] && [ $waited -lt $timeout ]; do
    sleep 2
    waited=$((waited + 2))
  done

  if [ ! -e "${xcode_git_path}" ]; then
    echo "Error: Command Line Tools installation timed out after ${timeout} seconds." >&2
    exit 1
  else
    echo "Command Line Tools installed successfully."
  fi
}

install_command_line_tool
