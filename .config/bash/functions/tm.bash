[ -n "$DOT_DEBUG" ] && echo "Load tm.bash"

tm() {
  [[ -n "$TMUX" ]] && tmode="switch-client" || tmode="attach-session"

  if [ $1 ]; then
    tmux $tmode -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi

  session=$(tmux list-session -F "#{session_name}" 2>/dev/null | fzf --exit-0) && tmux $change -t "$session" || echo "No sessions found."
}
