local function augroup(name)
  return vim.api.nvim_create_augroup("ginvim_" .. name, { alear = true })
end
