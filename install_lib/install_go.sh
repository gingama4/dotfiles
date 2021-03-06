#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/util.sh

if [ "$#" = 0 ]; then
  print_error "[install_go] No argument."
  exit 1
fi

version=$1
is_install="true"

if [[ "$#" = 2 ]] && [[ "$2" = "update" ]]; then
  go_version=$(go version | awk '{print $3}')
  current_version=${go_version:2}
  result=$(echo "${version//./} > ${current_version//./}" | bc)
  if [[ $result -eq 1 ]]; then
    if ! yes_or_no_select "Do you want to update from Go$current_version to Go$version?" ; then
      is_install="false"
    fi
  else
    is_install="false"
  fi
else
  if _has go; then
    print_info "Go is already installed."
    is_install="false"
  fi
fi

if [[ "$is_install" == true ]]; then
  wget -O ~/dottmp/golang.tar.gz https://golang.org/dl/go$version.linux-amd64.tar.gz
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ~/dottmp/golang.tar.gz
  rm ~/dottmp/golang.tar.gz

  check_exec="false"

  if _has go; then
    print_success $(go version)
    check_exec="true"
  fi
  
  if [[ "$check_exec" == false ]];then
    if yes_or_no_select "Do you want to add PATH to .bashrc?"
    then
      SOURCE_STR="\\nexport PATH=\$PATH:/usr/local/go/bin\\nexport GOPATH=\$HOME/go\nexport PATH=\$PATH:\$GOPATH/bin"
      print_default $SOURCE_STR
      echo "${SOURCE_STR}" >> ~/.bashrc
    fi
  fi
fi
