local lspconfig = require("lspconfig")

return {
  ts_ls = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    root_dir = lspconfig.util.root_pattern({ "package.json", "node_modules" }),
    single_file_support = false,
  },
}
