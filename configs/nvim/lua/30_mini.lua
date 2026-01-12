local now, later = MiniDeps.now, MiniDeps.later

now(function()
  require("mini.basics").setup({
    options = {
      extra_ui = true,
    },
    mappings = {
      option_toggle_prefix = "m",
    },
  })
end)

now(function()
  require("mini.icons").setup()
  later(MiniIcons.mock_nvim_web_devicons)
end)

now(function()
  require("mini.notify").setup()
  vim.notify = require("mini.notify").make_notify({})
end)

now(function()
  require("mini.tabline").setup()
end)
now(function()
  require("mini.statusline").setup()
  vim.opt.laststatus = 3
end)
now(function()
  require("mini.starter").setup()
end)

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

  GinVim.keymap.set({ "<Leader>gs", MiniGit.show_at_cursor, desc = "Show at cursor", mode = { "n", "x" } })
end)

later(function()
  require("mini.indentscope").setup()
end)

later(function()
  require("mini.misc").setup()
  MiniMisc.setup_auto_root()
  MiniMisc.setup_restore_cursor()
  MiniMisc.setup_termbg_sync()
end)

later(function()
  require("mini.pairs").setup()
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
