#!/usr/bin/env bash

function print_default() {
  echo -e "$*"
}

function print_info() {
  echo -e "\e[1;36m$*\e[m"
}

function print_notice() {
  echo -e "\e[1;35m$*\e[m"
}

function print_success() {
  echo -e "\e[1;32m$*\e[m"
}

function print_warning() {
  echo -e "\e[1;33m$*\e[m"
}

function print_error() {
  echo -e "\e[1;31m$*\e[m"
}

function whichdistro() {
  if [ -f /etc/arch-release ]; then
    echo arch
  elif [ -f /etc/debian_version ]; then
    echo debian
  fi
}

function checkinstall() {
  local distro
  distro=$(whichdistro)

  local pkgs="$*"
  if [[ $distro == "arch" ]]; then
    sudo pacman -S --noconfirm --needed $pkgs
  elif [[ $distro == "debian" ]]; then
    sudo DEBIAN_FRONTEND=noninteractive apt install -y $pkgs
  else
    :
  fi
}

function yes_or_no_select() {
  local answer
  local message
  if [[ -n "$*" ]]; then
    message=$*
  else
    message="Are you ready?"
  fi
  print_notice $message" [yes/no]"
  read -r answer
  case $answer in
  yes | y)
    return 0
    ;;
  no | n)
    return 1
    ;;
  *)
    if [[ "$DOT_DEBUG" = true ]]; then
      return 0
    else
      yes_or_no_select $message
    fi
    ;;
  esac
}

function _has() {
  type "$1" > /dev/null 2>&1
}

function mkdir_not_exist() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
  fi
}
