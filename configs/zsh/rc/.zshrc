# source command override
function source {
  ensure_zcompiled "$1"
  builtin source "$1"
}

function ensure_zcompiled {
  local target_dir="$HOME/.config/zsh"
  local compiled="$1.zwc"

  if [[ "$1" == "$target_dir/"* ]]; then
    if [[ ! -r "$compiled" || "$1" -nt "$compiled" ]]; then
      echo "\033[1;36mCompiling\033[m $1"
      zcompile "$1" "$compiled"
    fi
  fi
}

ensure_zcompiled "${ZDOTDIR}/.zshrc"

# sheldon cache
sheldon_cache="${SHELDON_CONFIG_DIR}/sheldon.zsh"
sheldon_toml="${SHELDON_CONFIG_DIR}/plugins.toml"
if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
  sheldon lock --update
  sheldon source > "$sheldon_cache"
fi
source "$sheldon_cache"
unset sheldon_cache sheldon_toml

source "${ZDOTDIR}/base.zsh"
source "${ZDOTDIR}/function.zsh"

zsh-defer unfunction source

