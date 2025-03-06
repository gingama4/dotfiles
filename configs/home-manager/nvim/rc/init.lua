vim.loader.enable()
vim.uv = vim.uv or vim.loop

local lazypath = "@lazy_nvim@"
vim.opt.rtp:prepend(lazypath)

local configpath = "@gingama4_nvim_config_path@"
vim.opt.rtp:prepend(configpath)

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
})

require("config").setup()
