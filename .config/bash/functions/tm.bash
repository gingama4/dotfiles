[ -n "$DOT_DEBUG" ] && echo "Load tm.bash"

tm() {
  if [[ -n "$TMUX" ]]; then
    local tmode="switch-client"
  else
    local tmode="attach-session"
  fi

  if [ $# != 0 ]; then
    if tmux $tmode -t $1 2>/dev/null; then
      tmux $tmode -t $1
    else
      tmux new-session -d -s $1 && tmux $tmode -t $1
    fi
    return 0
  fi

  local ID=$(tmux list-sessions 2> /dev/null)
  if [ -z "$ID" ]; then
    tmux new-session
    return 0
  fi

  local session=$(tmux list-sessions -F "#{session_name}" | fzf --select-1)

  if [ -n "$session" ]; then
    tmux $tmode -t "$session"
  fi
}
