local add = vim.pack.add
local later = GinVim.later

later(function ()
  add({
    "https://github.com/lambdalisue/nvim-aibo",
  })

  require("aibo").setup()
end)

