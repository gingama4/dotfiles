# --------------------------------------
# fzf
# --------------------------------------
[ -f ~/.config/fzf/fzf.zsh ] && source ~/.config/fzf/fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--reverse --border --ansi'

rc_dir="${ZDOTDIR}/rc"

# --------------------------------------
# Options
# --------------------------------------
source "${rc_dir}/options.zsh"

# --------------------------------------
# Prompt(Default)
# --------------------------------------
source "${rc_dir}/prompt.zsh"

# --------------------------------------
# Function
# --------------------------------------
source "${rc_dir}/functions.zsh"

# --------------------------------------
# Key Bindings
# --------------------------------------
source "${rc_dir}/bindkey.zsh"

# --------------------------------------
# Alias
# --------------------------------------
source "${rc_dir}/alias.zsh"

# --------------------------------------
# Plugin
# --------------------------------------
source "${rc_dir}/plugins.zsh"

unset rc_dir
