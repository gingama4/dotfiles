#!/bin/sh
ESC=$(printf '\033') RESET="${ESC}[0m"

printf "${ESC}[32m%s${RESET}\n" "git setup"
printf "${ESC}[36m%s${RESET}\n" "Please enter your name and email address."
printf "${ESC}[36m%s${RESET}\n" "(These are used by gitconfig)"

echo -n INPUT_USER_NAME:
read username

echo -n INPUT_EMAIL_ADD:
read useremail

cp $PWD/gitconfig ~/.gitconfig
git config --global user.name $username
git config --global user.email $useremail
