return {
  name = "nvim-cmp",
  dir = "@nvim_cmp@",
  event = "InsertEnter",
  dependencies = {
    { name = "cmp-nvim-lsp", dir = "@cmp_nvim_lsp@" },
    { name = "cmp-buffer", dir = "@cmp_buffer@" },
    { name = "cmp-path", dir = "@cmp_path@" },
    {
      name = "copilot-cmp",
      dir = "@copilot_cmp@",
      config = function()
        require("copilot_cmp").setup()
      end,
    },
    { name = "cmp-skkeleton", dir = "@cmp_skkeleton@" },
  },
  opts = function()
    local cmp = require("cmp")
    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
      end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    end

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
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
        ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "lazydev" },
        { name = "copilot", group_index = 1, priority = 100 },
        { name = "nvim_lsp" },
        { name = "skkeleton" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
      formatting = {
        format = function(_, item)
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
      experimental = {
        ghost_text = true,
      },
    }
  end,
  config = function(_, opts)
    local cmp = require("cmp")
    cmp.setup(opts)
  end,
}
