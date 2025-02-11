require("gingama4.config").init()

return {
  {
    name = "folke/lazy.nvim",
    dir = "@lazy_nvim@",
    version = "*"
  },
  {
    name = "folke/snacks.nvim",
    dir = "@snacks_nvim@",
    priority = 1000,
    lazy = false,
    opts = {},
    config = function(_, opts)
      require("snacks").setup(opts)
    end,
  },
}
