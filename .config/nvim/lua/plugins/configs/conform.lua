return function()
  local timeout_ms = 10000

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      local ignore_filetypes = {}
      if vim.tbl_contains(ignore_filetypes, vim.bo[args.buf].filetype) then
        return
      end
      local bufname = vim.api.nvim_buf_get_name(args.buf)
      if bufname:match("/node_modules/") then
        return
      end
      require("conform").format({ timeout_ms = timeout_ms, lsp_fallback = true, bufnr = args.buf })
    end,
  })

  local configs = require('utils.format.loader').load()

  require("conform").setup({
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = timeout_ms, lsp_fallback = true }
    end,
    formatters = configs.formatters,
    formatters_by_ft = configs.formatters_by_ft,
  })
end
