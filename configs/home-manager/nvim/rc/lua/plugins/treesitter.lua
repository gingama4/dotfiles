return {
  name = "nvim-treesitter",
  dir = "@nvim_treesitter@",
  event = { "LazyFile", "VeryLazy" },
  init = function()
    vim.opt.runtimepath:append("@treesitter_parsers@")
  end,
  opts = {
    auto_install = false,
    highlight = { enable = true },
    indent = { enabled = true },
  },
}
