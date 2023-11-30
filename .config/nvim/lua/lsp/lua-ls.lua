local capabilities = vim.tbl_deep_extend('force',
  vim.lsp.protocol.make_client_capabilities(),
  {}
)

return {
  lsp = 'lua_ls',
  settings = {
    capabilities = capabilities,
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
          }
        },
        diagnostics = {
          globals = { 'vim' },
        },
        hint = { enable = true },
        format = {
          enable = true,
          defaultConfig = {
            indent_style = 'tab',
            indent_size = '2',
          }
        },
      },
    },
  },
}

