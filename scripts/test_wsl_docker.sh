#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
  set -x
fi

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
readonly IMAGE_NAME="${DOTFILES_WSL_TEST_IMAGE:-dotfiles-wsl-ubuntu-test}"
readonly PLATFORM="${DOTFILES_WSL_TEST_PLATFORM:-linux/amd64}"
readonly NIX_VOLUME="${DOTFILES_WSL_TEST_NIX_VOLUME:-dotfiles-wsl-nix-store-amd64}"

docker build \
  --platform "${PLATFORM}" \
  --file "${ROOT_DIR}/docker/wsl-ubuntu/Dockerfile" \
  --tag "${IMAGE_NAME}" \
  "${ROOT_DIR}/docker/wsl-ubuntu"

docker volume create "${NIX_VOLUME}" > /dev/null

docker run --rm \
  --platform "${PLATFORM}" \
  --volume "${ROOT_DIR}:/workspace/dotfiles:ro" \
  --volume "${NIX_VOLUME}:/nix" \
  "${IMAGE_NAME}"
