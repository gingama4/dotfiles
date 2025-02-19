return {
  { import = "gingama4.plugins.ui.bufferline" },
  {
    name = "rebelot/kanagawa.nvim",
    dir = "@kanagawa_nvim@",
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd("colorscheme kanagawa")
    end,
  },
  {
    name = "echasnovski/mini.icons",
    dir = "@mini_icons@",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
