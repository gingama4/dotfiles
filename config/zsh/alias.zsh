# Alias Settings

# Replace ls with exa
if type "exa" > /dev/null 2>&1; then
  alias ls="exa --icons"
fi

alias la="ls -la"

alias n="nvim"
alias v="vim"
