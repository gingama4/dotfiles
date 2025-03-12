return {
  name = "nvim-cmp",
  dir = "@nvim_cmp@",
  event = "InsertEnter",
  dependencies = {
    { name = "cmp-nvim-lsp", dir = "@cmp_nvim_lsp@" },
    { name = "cmp-buffer", dir = "@cmp_buffer@" },
    { name = "cmp-path", dir = "@cmp_path@" },
  },
  opts = function()
    local cmp = require("cmp")
    return {
      window = {
        completion = cmp.config.window.bordered({
          border = "rounded",
        }),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "lazydev" },
        { name = "nvim_lsp" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
      formatting = {
        format = function(entry, item)
          local icons = GinVim.icons
          local kinds = icons.kinds
          if kinds[item.kind] then
            item.kind = kinds[item.kind] .. item.kind
          end

          local widths = {
            abbr = 40,
            menu = 30,
          }

          for key, width in pairs(widths) do
            if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
              item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. icons.misc.dots
            end
          end

          return item
        end,
      },
    }
  end,
  config = function(_, opts)
    local cmp = require("cmp")
    cmp.setup(opts)
  end,
}
