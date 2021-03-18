##= ENV ======================================

set -g TERM xterm-256color

##= Alias ====================================
alias lg='lazygit'
alias ld='lazydocker'
alias dc='docker-compose'

function fish_prompt
    set module "user,cwd,git,root,newline"
    set duration (math -s6 "$CMD_DURATION / 1000")
    powerline-go -modules $module -error $status -shell bare
end
