[ -n "$DOT_DEBUG" ] && echo "Load ghq-fzf.bash"

ghq-fzf() {
	local selected_dir
	selected_dir="$(ghq list | fzf-tmux --select-1 --exit-0 --preview \
		"ls -1a $(ghq root)/{}")"

	cd $(ghq root)/$selected_dir
}
