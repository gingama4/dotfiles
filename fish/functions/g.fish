function g
    ghq list | peco | read foo
    if [ $foo ]
        cd (ghq root)/$foo
    else
        commandline ''
    end
end
