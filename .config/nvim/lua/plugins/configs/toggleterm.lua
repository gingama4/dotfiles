return function(_,opts)
    local toggleterm = require 'toggleterm'
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({
      cmd = 'lazygit',
      direction = 'float',
      hidden = true,
      float_opts = {
        border = "double",
      },
      on_open = function(term)
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<Esc>", { noremap = true, silent = true })
      end,
    })
    function __lazygit_toggle()
      lazygit:toggle()
    end

    toggleterm.setup(opts)
end
