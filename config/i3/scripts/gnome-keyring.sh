#!/bin/env bash

if [ -z "$SSH_AUTH_SOCK" ];then
  eval $(gnome-keyring-daemon --start)
  export SSH_AUTH_SOCK
else
  echo "already SSH_AUTH_SOCK"
fi

