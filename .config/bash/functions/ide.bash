[ -n "$DOT_DEBUG" ] && echo "Load ide.bash"

ide() {
  if [  -z "$TMUX" ];then
    echo "tmux is not running."
    return 1
  fi

  tmux split-window -v -p 30
  tmux split-window -h -p 66
  tmux split-window -h -p 50 
}
