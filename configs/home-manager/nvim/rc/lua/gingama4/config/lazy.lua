local lazypath = "@lazy_nvim@"
vim.opt.rtp:prepend(lazypath)

-- Plugin Setup
require("lazy").setup({
  spec = {
    { import = "gingama4.plugins" },
  },
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
