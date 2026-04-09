function _cdghq() {
  local root="$(ghq root)"
  local repo="$(ghq list | fzf --preview="eza -1F --icons --color=always ${root}/{1}")"
  local dir="${root}/${repo}"

  [ -n "${repo}" ] && cd "${dir}"
  zle accept-line
  zle reset-prompt
}

zle -N _cdghq
bindkey '^g' _cdghq 
