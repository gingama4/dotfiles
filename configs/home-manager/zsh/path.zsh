export OS=`uname -s`
export ARCH=`uname -m`

if [ "$OS" = 'Darwin' ];then
  MAC_DEFAULT_PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

  # homebrew
  export PATH="/opt/homebrew/bin:${MAC_DEFAULT_PATH}"

  # nix
  export PATH="/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:${PATH}"
  export PATH="/etc/profiles/per-user/${USER}/bin:${PATH}"
  export PATH="${XDG_STATE_HOME}/nix/profiles/profile/bin:${PATH}"
fi
