return {
  name = "nvim-lspconfig",
  dir = "@nvim_lspconfig@",
  event = "LazyFile",
  opts = {
    servers = {},
  },
  config = function(_, opts)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local defaultOpts = {
      capabilities = capabilities,
    }

    vim.lsp.config("*", defaultOpts)

    local load_servers = GinVim.language.load().servers
    local servers = vim.tbl_deep_extend("force", load_servers, opts.servers)

    for server, server_opts in pairs(servers) do
      vim.lsp.config(server, server_opts)
      vim.lsp.enable(server)
    end

    -- Global config
    local icons = GinVim.icons
    vim.diagnostic.config({
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = function(diagnostics)
          for d, icon in pairs(icons.diagnostics) do
            if diagnostics.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
          return "●"
        end,
      },
      severity_sort = true,
      float = {
        border = "rounded",
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
          [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
          [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
        },
        linehl = {
          [vim.diagnostic.severity.ERROR] = "DiagnosticsSignError",
          [vim.diagnostic.severity.WARN] = "DiagnosticsSignWarn",
          [vim.diagnostic.severity.HINT] = "DiagnosticsSignHint",
          [vim.diagnostic.severity.INFO] = "DiagnosticsSignInfo",
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = "DiagnosticsSignError",
          [vim.diagnostic.severity.WARN] = "DiagnosticsSignWarn",
          [vim.diagnostic.severity.HINT] = "DiagnosticsSignHint",
          [vim.diagnostic.severity.INFO] = "DiagnosticsSignInfo",
        },
      },
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({ border = "single" })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.buf.hover({ border = "single" })
  end,
}
