export OS=`uname -s`
export ARCH=`uname -m`

if [ "$OS" = 'Darwin' ];then
  MAC_DEFAULT_PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

  # homebrew
  export PATH="/opt/homebrew/bin:${MAC_DEFAULT_PATH}"
fi
