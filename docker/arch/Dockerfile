FROM archlinux:latest

RUN pacman -Syyu --noconfirm && \
    pacman -S --noconfirm wget git sudo

ARG USERNAME=dottest
ARG GROUPNAME=dottest
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME && \
    passwd -d $USERNAME

ENV DOT_DEBUG="true"

USER $USERNAME
WORKDIR /home/$USERNAME/
