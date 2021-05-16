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
