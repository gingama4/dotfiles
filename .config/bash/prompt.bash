[ -n "$DOT_DEBUG" ] && echo "Load prompt.bash"

function _update_ps1() {
	PS1="$($GOPATH/bin/powerline-go -error $? -modules cwd,git,root -cwd-mode dironly)"
}

if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
	PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
