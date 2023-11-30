return function()
  local cmp = require 'cmp'
  local lspkind_status_ok, lspkind = pcall(require, 'lspkind')
  local utils = require 'utils'

  local border_opts = {
    border = 'rounded',
    winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
  }

  local function has_words_before()
    local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
  end

  cmp.setup({
    enabled = function()
      return true
    end,
    preselect = cmp.PreselectMode.None,
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = lspkind_status_ok and lspkind.cmp_format(utils.plugin_opts 'lspkind.nvim') or nil,
    },
    duplicates = {
      nvim_lsp = 1,
      luasnip = 1,
      cmp_tabnine = 1,
      buffer = 1,
      path = 1,
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      completion = cmp.config.window.bordered(border_opts),
      documentation = cmp.config.window.bordered(border_opts),
    },
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ['<C-k>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ['<C-j>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ['<C-y>'] = cmp.mapping.disable,
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources {
      { name = 'nvim_lsp', priority = 1000 },
      { name = 'buffer', priority = 500 },
      { name = 'path', priority = 250 },
    },
  })

end
