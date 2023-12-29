# ENV File

# XDG
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/1000}"

# zsh
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export SHELDON_CONFIG_DIR="${ZDOTDIR}/sheldon"

# GO
export GOPATH="${XDG_DATA_HOME}/go"
export PATH="${PATH}:${GOPATH}/bin"

# RUST
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export PATH="${PATH}:${CARGO_HOME}/bin"

# Docker
export DOCKER_HOST="unix://${XDG_RUNTIME_DIR}/docker.sock"

