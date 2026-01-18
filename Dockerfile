FROM ubuntu:latest

# 必要最小限のパッケージのインストール
RUN apt-get update && \
    apt-get install -y \
      sudo \
      git \
      wget

# ユーザ作成
ARG USER=dotuser
ARG GROUP=dotgroup
ARG UID=1001
ARG GID=1001
RUN groupadd -g $GID $GROUP && \
    useradd -m -s /bin/bash -u $UID -g $GID $USER && \
    echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USER
WORKDIR /home/$USER/dotfiles

COPY . /home/$USER/dotfiles

CMD ["/bin/bash"]
