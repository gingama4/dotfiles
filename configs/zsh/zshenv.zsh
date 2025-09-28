# XDG
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/1000}"

# zsh
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# sheldon
export SHELDON_CONFIG_DIR="${ZDOTDIR}/sheldon"
export SHELDON_DATA_DIR="${XDG_DATA_HOME}/sheldon"

# enhancd
export ENHANCD_DIR="${XDG_DATA_HOME}/enhancd"

# path
if [[ -z "$ZSH_PATH_LOADED" ]]; then
  source "${ZDOTDIR}/path.zsh"
  export ZSH_PATH_LOADED=1
fi

