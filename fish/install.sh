#!/bin/sh
ESC=$(printf '\033') RESET="${ESC}[0m"

printf "${ESC}[32m%s${RESET}\n" "fish setup"

path=~/.config/fish

if [ ! -L $path/config.fish ];then
    echo "link config"
    rm $path/config.fish
    ln -s $PWD/config.fish $path/config.fish
fi

