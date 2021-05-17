[ -z "$DOT_DEBUG" ] && echo "Load function_init.bash"

f-d-view() {
	if [ -z "$1" ]; then
		echo "No argument"
		return 1
	fi

	if [ -d "$1" ]; then
		exa --all --tree --icons --level=2 --git-ignore $1
		return 0
	elif [ -f "$1" ]; then
		bat --style=numbers --color=always --line-range :20 $1
		return 0
	fi

	return 0
}

current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
echo $current_dir

if [ -d "$current_dir/functions" ]; then
  echo "Load functions =================="
	for f in $current_dir/functions/*.bash ; do
		. $f
	done
	unset f
else
  echo "Not exist $current_dir/functions"
fi
