local M = {}

M.filetypes = {
  "css",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

M.formatters_by_ft = {}

function M.makeFt()
  for _, ft in ipairs(M.filetypes) do
    M.formatters_by_ft[ft] = { "prettier" }
  end

  return M.formatters_by_ft
end

return {
  formatters = {
    formatters_by_ft = M.makeFt(),
  },
}
