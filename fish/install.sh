#!/bin/sh
ESC=$(printf '\033') RESET="${ESC}[0m"

printf "${ESC}[32m%s${RESET}\n" "fish setup"

path=~/.config/fish

target="config.fish"

for v in $target; do
    echo "link ${v}"
    if [ ! -L $path/$v -o -f $path/$v ];then
        rm $path/$v
    fi
    ln -sf $PWD/$v $path/$v
done

for file in `\find $PWD/functions -name '*.fish'`; do
    bfile=$(basename "$file")
    echo "link ${bfile}"
    ln -sf $PWD/functions/$bfile $path/functions/$bfile
done
