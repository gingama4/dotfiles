local lspconfig = require("lspconfig")
local typescriptDir = "@typescript@"
local vueDir = "@vue_language_server@"

return {
  volar = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
    },
    root_dir = lspconfig.util.root_pattern({ "package.json" }),
    single_file_support = true,
    init_options = {
      typescript = {
        tsdk = vim.fs.joinpath(typescriptDir, "lib", "node_modules", "typescript", "lib"),
      },
      vue = {
        hybridMode = false,
      },
    },
  },
  ts_ls = {
    filetypes = {
      "vue",
    },
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = vim.fs.joinpath(vueDir, "lib", "node_modules", "@vue", "language-server"),
          languages = { "javascript", "typescript", "vue" },
        },
      },
    },
  },
}
