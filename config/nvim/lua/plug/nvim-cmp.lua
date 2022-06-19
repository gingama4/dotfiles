vim.g.completopt = "menu,menuone,noselect"

local cmp = require('cmp')
local types = require('cmp.types')
local luasnip = require('luasnip')
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  formatting = {
    format = require("lspkind").cmp_format({
      with_text = true,
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        cmp_tabnine = "[TabNine]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[NeoVimLua]",
        path = "[Path]",
        omni = "[Omni]",
        spell = "[Spell]",
        emoji = "[Emoji]",
        calc = "[Calc]",
        rg = "[Rg]",
        treesitter = "[TS]",
        cmdline_history = "[Histroy]"
      },
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {},
  --mapping = cmp.mapping.preset.insert({
  --  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --  ['<C-Space>'] = cmp.mapping.complete(),
  --  ['<C-e>'] = cmp.mapping.abort(),
  --  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  --}),
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c"}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c"}),
    ['<Up>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      else
        vim.api.nvim_feedkeys(t("<Up>"), "n", true)
      end
    end, { "i" }),
    ['<Down>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        vim.api.nvim_feedkeys(t("<Down>"), "n", true)
      end
    end, { "i" }),
    ['<Tab>'] = cmp.mapping(function(fallback) 
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s"}),
    ['<S-Tab>'] = cmp.mapping(function(fallback) 
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s"}),
    ['<C-Up>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable(-1) then
        luasnip.expand_or_jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-Down>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-q>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    ['<CR>'] = cmp.mapping.confirm({ select= false }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 100 },
    { name = 'luasnip', priority = 20 },
    { name = 'path', priority = 100 },
    { name = 'emoji', insert = true, priority = 60 },
  }, {
    { name = 'buffer', priority = 50 },
    { name = 'omni', priority = 40 },
    { name = 'spell', priority = 40 },
    { name = 'treesitter', priority = 30 },
  }),
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' },
    { name = 'buffer' },
  }),
})

cmp.setup.cmdline(':', {
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "c" }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "c" }),
    ['<C-y>'] = {
      c = cmp.mapping.confirm({ select = false }),
    },
    ['<C-q>'] = {
      c = cmp.mapping.abort(),
    },
  },
  sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }, { { name = 'cmdline_history' } }),
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
