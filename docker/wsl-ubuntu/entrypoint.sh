#!/usr/bin/env bash

set -Eeuo pipefail

readonly TEST_USER="${USER:-gingama4}"

chown -R "${TEST_USER}:${TEST_USER}" /nix "/home/${TEST_USER}"

exec sudo --preserve-env=DOTFILES_DEBUG,DOTFILES_SOURCE_DIR \
  --set-home \
  --user "${TEST_USER}" \
  /usr/local/bin/run-dotfiles-wsl-test
