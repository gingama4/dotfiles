return function()
  vim.g.completeopt = "menu,menuone,noselect"

  local cmp = require('cmp')
  local types = require('cmp.types')
  local luasnip = require('luasnip')

  local function has_words_before()
    local unpack = unpack or table.unpack ---@diagnostic.disable-line: deprecated
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
  end

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  cmp.setup({
    formatting = {
      format = require('lspkind').cmp_format({
        with_text = true,
        menu = {
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          copilot = "[Copilot]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[NeovimLua]",
          path = "[Path]",
        },
      }),
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<Up>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t("<Up>"), "n", true)
        end
      end, { "i" }),
      ["<Down>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t("<Down>"), "n", true)
        end
      end, { "i" }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },

    sources = cmp.config.sources({
      { name = "copilot",  priority = 90 },
      { name = "nvim_lsp", priority = 100 },
      { name = "luasnip",  priority = 20 },
      { name = "path",     priority = 100 },
      { name = "nvim_lua", priority = 50 },
    }, {
      { name = "buffer", priority = 50 },
    }),
  })
end
