#!/usr/bin/env bash

set -Eeuo pipefail

if command -v nix > /dev/null 2>&1; then
  exit 0
fi

curl --proto '=https' --tlsv1.2 -sSf -L https://nixos.org/nix/install \
  | sh -s -- --no-daemon
