[ -n "$DOT_DEBUG" ] && echo "Load fzf-direct.bash"

fzf-direct() {
	local selected_ele
	selected_ele="$(exa --all --level=2 | fzf-tmux --select-1 --exit-0 --preview \
		"f-d-view {}")"

	if [ -d "$selected_ele" ]; then
		cd $selected_ele
	elif [ -f "$selected_ele" ]; then
		vim $selected_ele
	fi
}
