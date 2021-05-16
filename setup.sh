#!/usr/bin/env bash

set -ue

#
#- Functions
# function usage() {
  print_default "Usage: ${BASH_SOURCE[0]:-$0} [install | update | link] [--help | -h]" 0>&2
}

#
#- main
#

function main() {
  local current_dir
  current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
  source $current_dir/install_lib/util.sh
  
  local is_install="false"
  local is_update="false"
  local is_link="false"

  while [ $# -gt 0 ]; do
    case ${1} in
    --help | -h)
      usage
      exit 1
      ;;
    install)
      is_install="true"
      is_update="true"
      is_link="true"
      ;;
    update)
      is_install="true"
      is_update="true"
      is_link="false"
      ;;
    install)
      is_install="false"
      is_update="false"
      is_link="true"
      ;;
    *)
      echo "[ERROR] Invalid arguments '${1}'"
      usage
      exit 1
      ;;
    esac
    shift
  done

  if [[ "$is_install" == false && "$is_update" == false && "$is_link" == false ]]; then
    is_install="true"
    is_update="true"
    is_link="true"
  fi
}

main "$@"
