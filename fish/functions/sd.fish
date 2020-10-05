function sd
    if test (count $argv) = 0
        set dir (find . -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf)
    else
        set dir (find . -path "*$argv[1]*" -type d -print 2> /dev/null | fzf)
    end

    if [ $dir ]
        cd $dir
    end
end

