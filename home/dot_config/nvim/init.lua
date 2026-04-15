-- Support >= 0.12
if vim.fn.has("nvim-0.12") == 0 then
  vim.notify("Only Support >= Nvim 0.12.", vim.log.levels.ERROR)
  return
end

-- Plugin Manager
vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
})

local misc = require("mini.misc")

local GinVim = require("gin-vim")
GinVim.now = function(f) misc.safely("now", f)  end
GinVim.later = function(f) misc.safely("later", f)  end
GinVim.now_if_args = vim.fn.argc(-1) > 0 and GinVim.now or GinVim.later
GinVim.on_event = function(ev, f) misc.safely('event:' .. ev, f) end
_G.GinVim = GinVim
