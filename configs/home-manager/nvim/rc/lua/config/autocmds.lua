local function augroup(name)
  return vim.api.nvim_create_augroup("ginvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained", "BufEnter" }, {
  group = augroup("auto_reload"),
  pattern = "*",
  command = "checktime",
})
