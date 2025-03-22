local M = {}

function M.load()
  local servers = {}

  local files = {}
  local lazy = require("lazy.core.util")
  lazy.lsmod("plugins.coding.languages", function(file)
    files[#files + 1] = file
  end)
  table.sort(files)

  for _, file in ipairs(files) do
    local server = require(file)
    if type(server) ~= "table" then
      error("Invalid server configuration in " .. file)
    end
    servers = vim.tbl_deep_extend("force", servers, server)
  end

  return servers
end

return {
  name = "nvim-lspconfig",
  dir = "@nvim_lspconfig@",
  event = "LazyFile",
  opts = {
    servers = {},
  },
  config = function(_, opts)
    local lspconfig = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local defaultOpts = {
      capabilities = capabilities,
    }

    local load_servers = M.load()
    local servers = vim.tbl_deep_extend("force", load_servers, opts.servers)

    for server, server_opts in pairs(servers) do
      local o = vim.tbl_deep_extend("force", defaultOpts, server_opts)
      lspconfig[server].setup(o)
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
