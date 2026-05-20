FROM ubuntu:24.04

ARG USERNAME=gingama4
ARG USER_UID=10001
ARG USER_GID=10001

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=${USERNAME}
ENV HOME=/home/${USERNAME}
ENV PATH=/nix/var/nix/profiles/default/bin:/home/${USERNAME}/.nix-profile/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    file \
    git \
    sudo \
    xz-utils \
  && rm -rf /var/lib/apt/lists/*

RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

RUN groupadd --gid "${USER_GID}" "${USERNAME}" \
  && useradd --uid "${USER_UID}" --gid "${USER_GID}" --create-home --shell /bin/bash "${USERNAME}" \
  && printf '%s ALL=(ALL) NOPASSWD:ALL\n' "${USERNAME}" > "/etc/sudoers.d/${USERNAME}" \
  && chmod 0440 "/etc/sudoers.d/${USERNAME}"

COPY install-nix.sh /usr/local/bin/install-nix
COPY run-test.sh /usr/local/bin/run-dotfiles-wsl-test
COPY entrypoint.sh /usr/local/bin/dotfiles-wsl-entrypoint

RUN chmod 0755 \
  /usr/local/bin/dotfiles-wsl-entrypoint \
  /usr/local/bin/install-nix \
  /usr/local/bin/run-dotfiles-wsl-test

VOLUME ["/nix"]
WORKDIR /workspace/dotfiles

CMD ["/usr/local/bin/dotfiles-wsl-entrypoint"]
