##= ENV ======================================

# PATH
set -x PATH $HOME/.local/bin $PATH

# brew
set -x PATH /home/linuxbrew/.linuxbrew/bin $PATH
# anyenv
status --is-interactive; and source (anyenv init -|psub)
set -x PATH $GOPATH/bin $PATH

set -g TERM xterm-256color

##= Alias ====================================
alias lg='lazygit'

fish_vi_key_bindings
