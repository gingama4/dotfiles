# Basic settings

export LANG=ja_JP.UTF-8
setopt print_eight_bit
setopt correct
HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=10000
setopt share_history
setopt hist_reduce_blanks

autoload -U compinit
compinit
