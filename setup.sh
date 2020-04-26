#!/bin/sh

ESC=$(printf '\033') RESET="${ESC}[0m"

printf "${ESC}[36m%s${RESET}\n" "Setup gingama4's dotfiles!!"
printf "${ESC}[36m%s${RESET}\n" "Please enter your name and email address."
printf "${ESC}[36m%s${RESET}\n" "(These are used by gitconfig)"

echo -n INPUT_USER_NAME:
read username

echo -n INPUT_EMAIL_ADD:
read useremail

ln -sf ~/dotfiles/vim/.vimrc ~/.vimrc

cp ~/dotfiles/git/gitconfig ~/.gitconfig
git config --global user.name $username
git config --global user.email $useremail

printf "${ESC}[36m%s${RESET}\n" "Setup Complete"

