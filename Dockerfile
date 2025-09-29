FROM ubuntu:latest

# 必要最小限のパッケージのインストール
RUN apt-get update && \
    apt-get install -y \
      sudo \
      git \
      zsh \
      locales && \
    locale-gen en_US.UTF-8

# ユーザ作成
ARG USER=dotuser
ARG UID=1000
RUN useradd -m -s /bin/zsh -u $UID $USER && \
    echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USER
WORKDIR /home/$USER/dotfiles

COPY . /home/$USER/dotfiles

CMD ["/bin/zsh", "install.sh"]
WORKDIR /home/$USER/dotfiles
