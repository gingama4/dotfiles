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
    { src = "https://github.com/yetone/avante.nvim" },
  })

  require("avante").setup({
    provider = "copilot",
  })
end)
