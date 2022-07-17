# zshrc

# Load Config
ZSH_CONFIG_DIR="${HOME}/.config/zsh"

if [ -d $ZSH_CONFIG_DIR ]; then
  for file in ${ZSH_CONFIG_DIR}/**/*.zsh; do
    [ -r $file ] && source $file
  done
fi	

# STARSHP
if type "starship" > /dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

source /usr/share/nvm/init-nvm.sh
export SSH_AUTH_SOCK=~/.1password/agent.sock
