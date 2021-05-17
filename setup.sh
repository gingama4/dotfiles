#!/usr/bin/env bash

set -ue

#
#- Functions
#
function usage() {
  print_default "Usage: ${BASH_SOURCE[0]:-$0} [install | update | link | go-pack] [--help | -h]" 0>&2
}

#
#- main
#

function main() {
  local current_dir
  current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
  source $current_dir/install_lib/util.sh
  source $current_dir/.env

  export DOT_DEBUG
  
  local is_install="false"
  local is_update="false"
  local is_link="false"
  local is_go="false"

  if [ -d ~/dottmp ]; then
    print_warning "~/dottmp already exists."
    print_warning "It will be deleted after setup is complete."
    if ! yes_or_no_select "Continue setup?" ; then
      exit 0
    fi
  fi

  mkdir -p ~/dottmp

  while [ $# -gt 0 ]; do
    case ${1} in
    --help | -h)
      usage
      exit 1
      ;;
    install)
      is_install="true"
      is_update="false"
      is_link="true"
      is_go="false"
      ;;
    update)
      is_install="false"
      is_update="true"
      is_link="false"
      is_go="false"
      ;;
    link)
      is_install="false"
      is_update="false"
      is_link="true"
      is_go="false"
      ;;
    go-pack)
      is_install="false"
      is_update="false"
      is_link="false"
      is_go="true"
      ;;
    *)
      print_warning "[ERROR] Invalid arguments '${1}'"
      usage
      exit 1
      ;;
    esac
    shift
  done

  if [[ "$is_install" == false && "$is_update" == false && "$is_link" == false && "$is_go" == false ]]; then
    is_install="true"
    is_update="false"
    is_link="true"
    is_go="false"
  fi

  if [[ "$is_install" == true ]]; then
    print_info ""
    print_info "#################################"
    print_info " INSTALL"
    print_info "#################################"
    print_info ""

    if [[ -n "$INSTALL_GO_VERSION" ]]; then
      source  $current_dir/install_lib/install_go.sh $INSTALL_GO_VERSION
    fi

    if [[ -n "$INSTALL_NVM_VERSION" ]]; then
      source  $current_dir/install_lib/install_nvm.sh $INSTALL_NVM_VERSION
    fi
  fi

  if [[ "$is_update" == true ]]; then
    print_info ""
    print_info "#################################"
    print_info " UPDATE"
    print_info "#################################"
    print_info ""

    if [[ -n "$INSTALL_GO_VERSION" ]]; then
      source  $current_dir/install_lib/install_go.sh $INSTALL_GO_VERSION update
    fi

    if [[ -n "$INSTALL_NVM_VERSION" ]]; then
      source  $current_dir/install_lib/install_nvm.sh $INSTALL_NVM_VERSION update
    fi
  fi

  if [[ "$is_link" == true ]]; then
    print_info ""
    print_info "#################################"
    print_info " LINK"
    print_info "#################################"
    print_info ""

    source $current_dir/install_lib/link.sh
    source $current_dir/install_lib/link_vim.sh
  fi

  if [[ "$is_go" == true ]]; then
    source $current_dir/install_lib/install_go-pack.sh
  fi

  rm -rf ~/dottmp
}

main "$@"
