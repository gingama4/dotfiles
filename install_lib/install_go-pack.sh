#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/util.sh

if ! _has go ; then
  print_error "Go is not installed."
  exit 1
fi

print_info ""
print_info "Install & Update Go pack"
print_info ""

go get -u github.com/x-motemen/ghq
go get -u github.com/justjanne/powerline-go
