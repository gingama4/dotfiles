function ide
    if test -z "$TMUX"
        echo "tmux is not running."
        return
    end

    tmux split-window -v -p 30
    tmux split-window -h -p 66
    tmux split-window -h -p 50
end
