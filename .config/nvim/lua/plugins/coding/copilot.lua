return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigget = true,
        keymap = {
          accept = false,
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  -- add ai_accept action
  {
    "zbirenbaum/copilot.lua",
    opts = function()
      GinVim.cmp.actions.ai_accept = function()
        if require("copilot.suggestion").is_visible() then
          GinVim.create_undo()
          require("copilot.suggestion").accept()
          return true
        end
      end
    end,
  },
}
