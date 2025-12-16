local M = {}

M.augroup = vim.api.nvim_create_augroup("ginvim_config", { clear = true })

function M.create_autocmd(event, pattern, callback, desc)
  local opts = { group = M.augroup, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

M.on_pack = function(plugin_name, kinds, callback, desc)
  if vim.fn.has("nvim-0.12") == 0 then
    return
  end
  local f = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then
      return
    end
    if not ev.data.active then
      vim.cmd.packadd(plugin_name)
    end
    callback()
  end
  M.create_autocmd("PackChanged", "*", f, desc)
end

M.now_if_args = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later

M.luals_unique_definition = require("gin-vim.luals_unique")

local keymap = require("gin-vim.keymap")
M.keymap = keymap

return M
