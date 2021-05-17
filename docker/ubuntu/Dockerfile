FROM ubuntu:latest

RUN apt update && apt upgrade -y && \
    apt install -y \
        wget \
        git \
        sudo

ARG USERNAME=dottest
ARG GROUPNAME=dottest
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME && \
    passwd -d $USERNAME

RUN echo "Defaults visiblepw" >> /etc/sudoers && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV DOT_DEBUG="true"

USER $USERNAME
WORKDIR /home/$USERNAME/
