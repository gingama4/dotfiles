function gd () {
  local fzfSelect=$(ghq list | fzf --reverse --height 50% --border)
  if [ -n "$fzfSelect" ]; then
    cd "$(ghq root)/${fzfSelect}"
  fi
}

