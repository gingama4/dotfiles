#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/util.sh

if [ "$#" = 0 ]; then
  print_error "[install_nvm] No argument."
  exit 1
fi

version=$1
nvm_install="true"

if [[ "$#" = 2 ]] && [[ "$2" = "update" ]]; then
  nvm_install="true"
elif [ -d "~/.nvm" ] ; then
  print_info "nvm is already installed."
  nvm_install="false"
fi

if [[ "$nvm_install" == true ]]; then
  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v$version/install.sh | bash
fi
