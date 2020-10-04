##= PATH ====================================

# brew
set -x PATH /home/linuxbrew/.linuxbrew/bin $PATH
status --is-interactive; and source (anyenv init -|psub)

##= Alias ====================================
alias g='cd (ghq root)/(ghq list | peco)'
alias lag='lazygit'
alias lad='lazydocker'

