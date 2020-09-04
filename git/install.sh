#!/bin/sh
ESC=$(printf '\033') RESET="${ESC}[0m"

printf "${ESC}[32m%s${RESET}\n" "git setup"
if [ ! -f $PWD/config.txt ];then
    printf "${ESC}[36m%s${RESET}\n" "Please enter your name and email address."
    printf "${ESC}[36m%s${RESET}\n" "(These are used by gitconfig)"

    echo -n INPUT_USER_NAME:
    read username

    echo -n INPUT_EMAIL_ADD:
    read useremail

    echo "USER=${username}" > config.txt
    echo "MAIL=${useremail}" >> config.txt
else
    . $PWD/config.txt
    echo $USER
    echo $MAIL
    username=$USER
    useremail=$MAIL
fi

cp $PWD/gitconfig ~/.gitconfig
git config --global user.name $username
git config --global user.email $useremail
