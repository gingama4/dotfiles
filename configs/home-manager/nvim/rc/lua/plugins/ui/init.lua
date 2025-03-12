return {
  {
    name = "kanagawa.nvim",
    dir = "@kanagawa_nvim@",
    lazy = false,
    priority = 1000,
    build = ":KanagawaCompile",
    ---@module "kanagawa"
    ---@type KanagawaConfig
    opts = {
      compile = false,
      transparent = true,
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { fg = "#c34043", bg = "none" },
          FloatTitle = { bg = "none" },
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
        }
      end,
    },
    ---@param opts KanagawaConfig
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd("colorscheme kanagawa")
    end,
  },
  {
    name = "mini.icons",
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
  { import = "plugins.ui.bufferline" },
  { import = "plugins.ui.lualine" },
}
