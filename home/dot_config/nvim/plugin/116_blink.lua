local add = vim.pack.add
local later = GinVim.later

later(function ()
  add({
    { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
    "https://github.com/fang2hou/blink-copilot",
  })
  require("blink.cmp").setup({
    keymap = {
      ["<Tab>"] = {
        "snippet_forward",
        function()
          return vim.lsp.inline_completion.get()
        end,
        "fallback",
      },
    },
    completion = {
      menu = { border = "single" },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = { border = "single" },
      },
      ghost_text = {
        enabled = true,
      },
    },
    signature = { window = { border = "single" } },
    sources = {
      default = { "copilot", "snippets", "lsp", "path", "buffer" },
      per_filetype = {
        markdown = { "snippets", "lsp", "path" },
      },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          async = true,
        },
      }
    },
  })
end)

