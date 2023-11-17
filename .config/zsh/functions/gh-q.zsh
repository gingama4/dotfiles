function gh-q () {
  local fzfSelect=$(gh repo list | cut -f1 | fzf --reverse --height 50% --border)
  if [ -n "$fzfSelect" ]; then
    echo "Clone ${fzfSelect}?(y/N): "
    if read -q; then
      ghq get ${fzfSelect}
    fi
  fi
}

