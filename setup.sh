#!/bin/sh

ESC=$(printf '\033') RESET="${ESC}[0m"

printf "${ESC}[36m%s${RESET}\n" "Setup gingama4's dotfiles!!"

# git
bash ./git/install.sh

# vim
bash ./vim/install.sh

# tmux
bash ./tmux/install.sh

printf "${ESC}[36m%s${RESET}\n" "Setup Complete"

