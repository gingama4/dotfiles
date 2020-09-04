#!/bin/sh
ESC=$(printf '\033') RESET="${ESC}[0m"

printf "${ESC}[32m%s${RESET}\n" "tmux setup"

if [[ ! -d $HOME/.tmux-themepack ]]; then
    echo "clone tmux-themepack"
    git clone https://github.com/jimeh/tmux-thmepack.git ~/.tmux-themepack
fi

if [[ ! -d $HOME/.tmux-resurrect ]]; then
    echo "clone tmux-resurrect"
    git clone https://github.com/tmux-plugins/tmux-resurrect.git ~/.tmux-resurrect
fi

if [[ ! -e $HOME/.tmux.conf ]]; then
    echo "link tmux.conf"
    ln -sf ./tmux/tmux.conf ~/.tmux.conf

    case "$(uname)" in
        "Linux" )
            ln -sf ./tmux/tmux.conf.linux ~/.tmux.conf.linux
    esac
fi

