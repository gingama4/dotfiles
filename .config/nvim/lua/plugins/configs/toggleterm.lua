return function(_,opts)
    local toggleterm = require 'toggleterm'
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({ cmd = 'lazygit', direction = 'float', hidden = true })
    function __lazygit_toggle()
      lazygit:toggle()
    end

    toggleterm.setup(opts)
end
