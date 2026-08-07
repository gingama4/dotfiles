local add = vim.pack.add
local later = GinVim.later
local keymap = GinVim.keymap.set

local function has_config(bufnr, names)
  local file = vim.api.nvim_buf_get_name(bufnr)
  local dir = vim.fs.dirname(file)

  return vim.fs.find(names, {
    path = dir,
    upward = true,
  })[1] ~= nil
end

local function js_formatter(bufnr)
  if has_config(bufnr, { "biome.json", "biome.jsonc" }) then
    return { "biome" }
  end

  return {"eslint_d", "prettier"}
end

-- Formatting
later(function()
  add({ "https://github.com/stevearc/conform.nvim" })
  require("conform").setup({
    format_on_save = {
      timeout_ms = 3000,
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      php = { "pint" },
      blade = { "blade-formatter" },
      go = { lsp_format = "prefer" },
      javascript = js_formatter,
      typescript = js_formatter,
      tsx = js_formatter,
      astro = js_formatter,
      markdown = { "prettier" },
    },
  })

  keymap({ "<leader>ci", require("conform").format, desc = "Format" })
end)

