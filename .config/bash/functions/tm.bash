[ -z "$DOT_DEBUG" ] && echo "Load tm.bash"

tm() {
  test -n "$TMUX" && set tmode "switch-client" ;or set tmode "attach-session"

  if count $1 > /dev/null
    tmux $tmode -t $1 2>/dev/null ;or tmux new-session -d -s  $1 && tmux $tmode -t $1;
    return 0
  fi

  set ID (tmux list-sessions 2> /dev/null)
  if [ -z "$ID" ]; then
    tmux new-session
    return 0
  fi

  set session (tmux list-sessions -F "#{session_name}" | fzf --select-1 | cut -d; -f1)

  if [ -n "$session" ]; then
    tmux $tmode -t "$session"
  fi
}
