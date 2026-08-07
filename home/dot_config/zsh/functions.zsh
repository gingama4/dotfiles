function cgr() {
  if ! (( $+commands[ghq] && $+commands[fzf] )); then
    print -u2 "cgr requires ghq and fzf"
    return 1
  fi

  local root repo
  root="$(ghq root)" || return

  repo="$(
    ghq list |
      fzf --preview \
        'eza -1F --icons=auto --color=always "'"$root"'"/{}'
  )" || return

  cd "$root/$repo"
}

function _cgr_widget() {
  cgr
  zle reset-prompt
}
