local M = {}

M.augroup = vim.api.nvim_create_augroup("ginvim_config", { clear = true })

function M.autocmd(event, pattern, callback, desc)
  local opts = { group = M.augroup, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

function M.setup()
  vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained", "BufEnter" }, {
    group = M.augroup,
    pattern = "*",
    command = "checktime",
  })
end

return M
