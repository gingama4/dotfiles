return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "config.util",        words = { "GinVim" } },
        { path = "snacks.nvim",        words = { "Snacks" } },
        { path = "lazy.nvim",          words = { "GinVim" } },
      },
    },
  },
  { import = "plugins.coding.formatting" },
  { import = "plugins.coding.linting" },
  { import = "plugins.coding.nvim-cmp" },
}
