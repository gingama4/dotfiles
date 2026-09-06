local now, now_if_args, later = GinVim.now, GinVim.now_if_args, GinVim.later

-- #####################################
-- Step 1
-- #####################################

-- now(function() vim.cmd('colorscheme minisummer') end)

now(function()
  require("mini.basics").setup({
    options = { basic = false },
    mappings = { windows = true, move_with_alt = true },
    autocommands = { relnum_in_visual_mode = true },
  })
end)

now(function()
  require("mini.icons").setup()
  later(MiniIcons.mock_nvim_web_devicons)
  later(MiniIcons.tweak_lsp_kind)
end)

now(function()
  local predicate = function(notif)
    if not (notif.data.source == 'lsp_progress' and notif.data.client_name == 'lua_ls') then return true end
    return notif.msg:find('Diagnosing') == nil and notif.msg:find('semantic tokens') == nil
  end
  local custom_sort = function(notif_arr) return MiniNotify.default_sort(vim.tbl_filter(predicate, notif_arr)) end

  require("mini.notify").setup({ content = { sort = custom_sort } })
end)

now(function()
  require("mini.sessions").setup()
end)

now(function()
  require("mini.starter").setup()
end)

now(function()
  require("mini.statusline").setup()
end)

now(function()
  require("mini.tabline").setup()
end)

-- #####################################
-- Step 1.5
-- #####################################

now_if_args(function()
  require("mini.misc").setup({ make_global = { 'put', 'put_text', 'stat_summary', 'bench_time' } })
  MiniMisc.setup_auto_root()
  MiniMisc.setup_restore_cursor()
  MiniMisc.setup_termbg_sync()
end)

-- now_if_args(function()
--   local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
--   local process_items = function(items, base)
--     return MiniCompletion.default_process_items(items, base, process_items_opts)
--   end
--   require("mini.completion").setup({
--     lsp_completion = { source_func = 'omnifunc', auto_setup = false, process_items = process_items },
--   })
--
--   local on_attach = function(args) vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp' end
--   GinVim.create_autocmd('LspAttach', '*', on_attach, 'Custom `on_attach`')
--   vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
-- end)

-- #####################################
-- Step 2
-- #####################################

later(function()
  require("mini.extra").setup()
end)

later(function()
  local ai = require("mini.ai")
  ai.setup({
    custom_textobjects = {
      B = MiniExtra.gen_ai_spec.buffer(),
      F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
      o = ai.gen_spec.treesitter({ a = "@block.outer", i = "@block.inner" }),
    },
    search_method = "cover",
  })
end)

later(function()
  local miniclue = require("mini.clue")
  miniclue.setup({
    clues = {
      {
        { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
        { mode = "n", keys = "<Leader>c", desc = "+Code" },
        { mode = "n", keys = "<Leader>f", desc = "+Find" },
        { mode = "n", keys = "<Leader>g", desc = "+Git" },
      },
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows({ submode_resize = true }),
      miniclue.gen_clues.z(),
    },
    triggers = {
      { mode = "n", keys = "<Leader>" },
      { mode = "x", keys = "<Leader>" },
      { mode = "n", keys = "s" },
      { mode = "x", keys = "s" },
      { mode = "n", keys = "z" },
      { mode = "x", keys = "z" },
    },
  })
end)

later(function()
  require("mini.cmdline").setup()
end)

later(function()
  require("mini.comment").setup()
end)

later(function()
  require("mini.cursorword").setup()
end)

later(function()
  require("mini.diff").setup()
end)

later(function()
  require("mini.git").setup({
    command = {
      split = "vertical",
    },
  })
end)

later(function()
  require("mini.indentscope").setup()
end)

later(function()
  require("mini.input").setup()
end)

later(function()
  require("mini.keymap").setup()
  MiniKeymap.map_multistep('i', '<Tab>', { 'pmenu_next' })
  MiniKeymap.map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
  MiniKeymap.map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
  MiniKeymap.map_multistep('i', '<BR>', { 'minipairs_bs' })
end)

later(function()
  local map = require("mini.map")
  local gen_integr = map.gen_integration
  map.setup({
    symbols = { encode = map.gen_encode_symbols.dot('4x2') },
    integrations = { gen_integr.builtin_search(), gen_integr.diff(), gen_integr.diagnostic() },
  })
  for _, key in ipairs({ 'n', 'N', '*', '#' }) do
    vim.keymap.set('n', key, key .. 'zv<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>')
  end
end)

later(function()
  require("mini.pairs").setup({ modes = { insert = true, command = true, terminal = false } })
end)

later(function()
  require("mini.pick").setup()
  vim.ui.select = MiniPick.ui_select

  GinVim.keymap.set({ "<leader>fb", MiniPick.builtin.buffers, desc = "Buffers" })
  -- stylua: ignore
  GinVim.keymap.set({ "<leader>ff", function() MiniPick.builtin.files({ tool = 'git' }) end, desc = "Files" })
  GinVim.keymap.set({ "<leader>fg", MiniPick.builtin.grep_live, desc = "Grep" })
end)

later(function()
  require("mini.surround").setup()
end)
