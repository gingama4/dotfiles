return function(_, opts)
  require('alpha').setup(opts.config)
  local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
  autocmd("User", {
    pattern = "LazyVimStarted",
    once = true,
    callback = function()
      local stats = require("lazy").stats()
      local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
      local version = " v" ..
          vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
      local plugins = "⚡plugins " .. stats.loaded .. "/" .. stats.count .. " in " .. ms .. "ms"
      local footer = version .. "\t" .. plugins .. "\n"
      opts.section.footer.val = footer
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
  -- Disable the statusline, tabline and cmdline while the alpha dashboard is open
  autocmd('User', {
    pattern = 'AlphaReady',
    desc = 'disable status, tabline and cmdline for alpha',
    callback = function()
      vim.go.laststatus = 0
      vim.opt.showtabline = 0
      vim.opt.cmdheight = 0
    end,
  })
  autocmd('BufUnload', {
    buffer = 0,
    desc = 'enable status, tabline and cmdline after alpha',
    callback = function()
      vim.go.laststatus = 3
      --vim.opt.showtabline = 2
      vim.opt.cmdheight = 1
    end,
  })
end
