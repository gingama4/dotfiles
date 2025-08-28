return {
  name = "nvim-treesitter",
  dir = "@nvim_treesitter@",
  event = { "LazyFile", "VeryLazy" },
  init = function()
    vim.opt.runtimepath:append("@treesitter_parsers@")
  end,
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
