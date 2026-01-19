# SSH Sign
export SSH_SIGNING_KEY="$HOME/.ssh/id_ed25519_github_sign"

case $OS in
  Darwin)
    ;;
  Linux)
    SSH_AGENT_SOCKET="$HOME/.ssh/agent.sock"

    if [[ -z "$SSH_AUTH_SOCK" ]]; then
      export SSH_AUTH_SOCK="$SSH_AGENT_SOCKET"
    fi

    if ! ssh-add -l >/dev/null 2>&1; then
      rm -f "$SSH_AGENT_SOCKET"
      eval "$(ssh-agent -a "$SSH_AGENT_SOCKET")" >/dev/null
      ssh-add "$SSH_SIGNING_KEY"
    fi
    ;;
esac
