_G.GinVim = require("util")
require("config.options")
GinVim.plugin.setup()

-- Plugin Setup
require("lazy").setup({
  spec = "plugins",
  checker = { enabled = true },
  performance = {
    reset_packpath = false,
    rtp = {
      reset = false,
    },
  },
  install = {
    missing = false,
  },
  ui = {
    border = "rounded",
  },
})

require("config.keymaps")
require("config.autocmds")
