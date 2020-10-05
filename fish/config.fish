##= ENV ======================================

# brew
set -x PATH /home/linuxbrew/.linuxbrew/bin $PATH
# anyenv
status --is-interactive; and source (anyenv init -|psub)

##= Alias ====================================
alias lg='lazygit'

fish_vi_key_bindings
