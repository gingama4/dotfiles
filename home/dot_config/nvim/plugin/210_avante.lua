local avante_make = function()
  vim.cmd("AvanteBuild")
end

GinVim.on_pack(
  "avante.nvim",
  { "install", "update" },
  avante_make,
  "Build avante.nvim"
)

GinVim.later(function()
  vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/zbirenbaum/copilot.lua",
  })
  vim.pack.add({
    "https://github.com/yetone/avante.nvim",
  })

  require("avante").setup({
    provider = "copilot",
    behaviour = {
      auto_suggestions = false,
      auto_approve_tool_permissions = false,
      auto_check_diagnostics = false,
    },
  })
end)
