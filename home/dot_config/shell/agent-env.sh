# shellcheck shell=sh
# Shared environment for interactive shells, non-interactive shells, and IDEs.
# Keep this file POSIX-compatible, fast, and completely silent.

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"

if [ -r /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  # shellcheck disable=SC1091
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
elif [ -r "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
  # shellcheck disable=SC1091
  . "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi

for dotfiles_session_vars in \
  "${HOME}/.nix-profile/etc/profile.d/hm-session-vars.sh" \
  "/etc/profiles/per-user/${USER:-}/etc/profile.d/hm-session-vars.sh" \
  "${XDG_STATE_HOME}/nix/profiles/profile/etc/profile.d/hm-session-vars.sh"
do
  if [ -r "${dotfiles_session_vars}" ]; then
    # shellcheck disable=SC1090
    . "${dotfiles_session_vars}"
    break
  fi
done
unset dotfiles_session_vars

dotfiles_path_prepend() {
  case ":${PATH:-}:" in
    *":$1:"*) ;;
    *) PATH="$1${PATH:+:${PATH}}" ;;
  esac
}

if [ -n "${USER:-}" ]; then
  dotfiles_path_prepend "/etc/profiles/per-user/${USER}/bin"
fi
dotfiles_path_prepend "${HOME}/.nix-profile/bin"
dotfiles_path_prepend "${HOME}/go/bin"
dotfiles_path_prepend "${HOME}/.local/share/mise/shims"
dotfiles_path_prepend "${HOME}/.local/bin"

export PATH
unset -f dotfiles_path_prepend 2>/dev/null || true
