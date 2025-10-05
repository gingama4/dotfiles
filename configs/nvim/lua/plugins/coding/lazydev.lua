return {
  name = "lazydev.nvim",
  dir = "@lazydev_nvim@",
  ft = "lua",
  cmd = "LazyDev",
  ---@module "lazydev"
  ---@type lazydev.Config
  opts = {
    ---@type lazydev.Library.spec
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "snacks.nvim", words = { "Snacks" } },
      { path = vim.g.my_config_path .. "/lua", words = { "GinVim" } },
    },
  },
}
