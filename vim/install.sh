#!/bin/sh
ESC=$(printf '\033') RESET="${ESC}[0m"

printf "${ESC}[32m%s${RESET}\n" "vim setup"

path=~/.vim

if [ ! -e $path ];then
    echo "make .vim"
	mkdir -p $path
fi

if [ ! -L $path/config ];then
    echo "link config"
    ln -s $PWD/config $path/config
fi

if [ ! -e $HOME/.vimrc ];then
    echo "link vimrc"
    ln -sf $PWD/vimrc $HOME/.vimrc
fi

if [ ! -d $path/undo ];then
    echo "make undo"
    mkdir $path/undo
fi

if [ ! -e $path/dein.toml ];then
    echo "link dein.toml"
    ln -sf $PWD/dein.toml $path/dein.toml
fi

