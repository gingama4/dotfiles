#!/bin/sh

ESC=$(printf '\033') RESET="${ESC}[0m"

printf "${ESC}[36m%s${RESET}\n" "Setup gingama4's dotfiles!!"

locale=$PWD

# git
cd $locale/git
bash install.sh

# vim
cd $locale/vim
bash install.sh

# tmux
cd $locale/tmux
bash install.sh

cd $locale
printf "${ESC}[36m%s${RESET}\n" "Setup Complete"

