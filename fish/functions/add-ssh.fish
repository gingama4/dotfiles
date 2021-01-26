function add-ssh
    eval (ssh-agent -c)
    if test (count $argv) = 0
        ssh-add ~/.ssh/id_rsa_github
    else
        ssh-add ~/.ssh/$argv[1]
    end
end
