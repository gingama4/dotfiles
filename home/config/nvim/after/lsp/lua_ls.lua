return {
  on_attach = function(client, buf_id)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    client.server_capabilities.completionProvider.triggerCharacters = { ".", ":", "#", "(" }

    local opts = { buffer = buf_id, desc = "Lua source definition" }
    vim.keymap.set("n", "<Leader>ls", GinVim.luals_unique_definition, opts)
  end,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.tbl_deep_extend("force", vim.split(package.path, ";"), {
          "lua/?.lua",
          "lua/?/init.lua",
        }),
      },
      diagnostics = {
        workspaceDelay = -1,
      },
      workspace = {
        ignoreSubmodules = true,
        checkThirdParty = false,
        library = vim.list_extend(vim.api.nvim_get_runtime_file("lua", true), {
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        }),
      },
      telemetry = { enable = false },
    },
  },
}
