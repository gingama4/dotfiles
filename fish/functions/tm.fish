function tm
    test -n "$TMUX" && set tmode "switch-client" ;or set tmode "attach-session"

    if count $argv > /dev/null
        tmux $tmode -t $argv[1] 2>/dev/null ;or tmux new-session -d -s $argv[1] && tmux $tmode -t $argv[1]; return
    end

    set ID (tmux list-sessions 2> /dev/null)
    if test -z "$ID"
        tmux new-session
        return
    end

    set session (tmux list-sessions -F "#{session_name}" | peco --on-cancel=error | cut -d: -f1)

    if test -n "$session"
        tmux $tmode -t "$session"
    end
end
