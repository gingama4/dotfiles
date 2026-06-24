GinVim.on_event('InsertEnter', function ()
  vim.pack.add({
     "https://github.com/zbirenbaum/copilot.lua",
     "https://github.com/copilotlsp-nvim/copilot-lsp",
  })

  local copilot_node_command = vim.env.EDITOR_NODE
  if copilot_node_command == nil or copilot_node_command == "" then
    copilot_node_command = "node"
  elseif vim.fn.isdirectory(copilot_node_command) == 1 then
    copilot_node_command = copilot_node_command .. "/bin/node"
  end

  require("copilot").setup({
    copilot_node_command = copilot_node_command,
    suggestion = { enabled = false },
    panel = { enabled = false },
    nes = {
      enabled = true,
      keymap = {
        accept = "<Tab>"
      },
    },
  })
end)
