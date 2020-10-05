function fish_user_key_bindings
    
    for mode in insert default visual
        bind -M $mode \cr 'peco_select_history'
    end
end

