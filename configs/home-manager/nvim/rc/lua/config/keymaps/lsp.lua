local lsp = vim.lsp
local buf = lsp.buf

-- stylua: ignore
return {
  { "gd", buf.definition, desc = "Goto Definition" },
  { "gr", buf.references, desc = "References" },
  { "gI", buf.implementation, desc = "Goto Implementation" },
  { "gy", buf.type_definition, desc = "Goto T[y]pe Definition" },
  { "gD", buf.declaration, desc = "Goto Declaration" },
  { "K", function() buf.hover({ border = "rounded", title = "Lsp Hover" }) end, desc = "hover" },
  { "gK", function() buf.signature_help({ border = "rounded", title = "Lsp Signature Help"}) end, desc = "Signature Help" },
  { "<leader>ca", buf.code_action, desc = "Code Action", mode = { "n", "v" } },
  { "<leader>cc", lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" } },
  { "<leader>cC", lsp.codelens.refresh, desc = "Refresh Codelens" },
  { "<leader>cr", buf.rename, desc = "Rename" },
}
