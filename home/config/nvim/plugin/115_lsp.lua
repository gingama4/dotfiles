local add = vim.pack.add
local later = GinVim.later

later(function ()
  add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/copilotlsp-nvim/copilot-lsp",
  })
  vim.lsp.enable({
    "astro",
    "copilot",
    "lua_ls",
    "intelephense",
    "gopls",
    "vtsls",
    "eslint",
  })

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "",
      },
    },
  })

  local completion_group = vim.api.nvim_create_augroup("user-lsp-completion", { clear = true })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = completion_group,

    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if not client then
        return
      end

      if not client:supports_method('textDocument/completion') then
        return
      end

      local completion_provider = client.server_capabilities.completionProvider

      if completion_provider then
        local triggers = completion_provider.triggerCharacters or {}

        for c in ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"):gmatch(".") do
          if not vim.tbl_contains(triggers, c) then
            table.insert(triggers, c)
          end
        end

        completion_provider.triggerCharacters = triggers
      end

      vim.lsp.completion.enable(
        true,
        client.id,
        event.buf,
        {
          autotrigger = true,
        }
      )
    end,
  })
end)
