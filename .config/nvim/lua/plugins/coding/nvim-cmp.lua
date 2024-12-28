return {
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local auto_select = true
      return {
        auto_branckets = {},
        completion = {
          completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
        },
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = GinVim.cmp.confirm({ select = auto_select }),
          ["<C-y>"] = GinVim.cmp.confirm({ select = true }),
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          --["<tab>"] = function(fallback)
          --  return GinVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
          --end,
          ["<tab>"] = cmp.mapping(function(fallback)
            local col = vim.fn.col(".") - 1
            if cmp.visible() then
              cmp.select_next_item()
            elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
              GinVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
            else
              cmp.complete()
            end
          end, { "i", "s" }),
          ["<S-tab>"] = cmp.mapping(function(fallback)
            local col = vim.fn.col(".") - 1
            if cmp.visible() then
              cmp.select_prev_item()
            elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
              GinVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
            else
              cmp.complete()
            end
          end, { "i", "s" }),
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
            local icons = GinVim.config.icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end

            local widths = {
              abbr = 40,
              menu = 30,
            }

            for key, width in pairs(widths) do
              if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
              end
            end

            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
    main = "config.util.cmp",
  },

  -- snippets
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "garymjr/nvim-snippets",
        opts = {
          friendly_snippets = true,
        },
        dependencies = { "rafamadriz/friendly-snippets" },
      },
    },
    opts = function(_, opts)
      opts.snippet = {
        expand = function(item)
          return GinVim.cmp.expand(item.body)
        end,
      }
      if GinVim.has("nvim-snippets") then
        table.insert(opts.sources, { name = "snippets" })
      end
    end,
  },

  -- copilot
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require("copilot_cmp")
          copilot_cmp.setup(opts)
          GinVim.lsp.on_attach(function()
            copilot_cmp._on_insert_enter({})
          end, "copilot")
        end,
      },
    },
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "copilot",
        group_index = 1,
        priority = 100,
      })
    end,
  },
}
