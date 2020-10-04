#!/bin/sh

ESC=$(printf '\033') RESET="${ESC}[0m"

printf "${ESC}[36m%s${RESET}\n" "Setup gingama4's dotfiles!!"

locale=$PWD

target="git vim tmux fish"

for v in $target; do
    cd $locale/$v
    bash install.sh
done

cd $locale
printf "${ESC}[36m%s${RESET}\n" "Setup Complete"

