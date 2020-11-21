function gd
    ls $GOPATH/src/github.com/$USER | peco | read foo
    if [ $foo ]
        cd $GOPATH/src/github.com/$USER/$foo
    else
        commandline ''
    end
end
