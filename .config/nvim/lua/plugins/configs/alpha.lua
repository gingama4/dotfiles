local function capture(cmd, raw)
  local f = assert(io.popen(cmd, "r"))
  local s = assert(f:read("*a"))
  f:close()
  if raw then
    return s
  end
  s = string.gsub(s, "^%s+", "")
  s = string.gsub(s, "%s+$", "")
  s = string.gsub(s, "[\n\r]+", " ")
  return s
end

local function split(source, sep)
  local result, i = {}, 1
  while true do
    local a, b = source:find(sep)
    if not a then
      break
    end
    local candidat = source:sub(1, a - 1)
    if candidat ~= "" then
      result[i] = candidat
    end
    i = i + 1
    source = source:sub(b + 1)
  end
  if source ~= "" then
    result[i] = source
  end
  return result
end

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
  vim.api.nvim_create_augroup("vimrc_alpha", { clear = true })
  autocmd('User', {
    group = "vimrc_alpha",
    pattern = 'AlphaReady',
    callback = function()
      vim.go.laststatus = 0
      vim.opt.showtabline = 0
      vim.opt.cmdheight = 0
      if vim.fn.executable("onefetch") == 1 then
        local header = split(
          capture(
            [[onefetch 2>/dev/null | sed 's/\x1B[@A-Z\\\]^_]\|\x1B\[[0-9:;<=>?]*[-!"#$%&'"'"'()*+,.\/]*[][\\@A-Z^_`a-z{|}~]//g']],
            true
          ),
          "\n"
        )
        if next(header) ~= nil then
          require("alpha.themes.dashboard").section.header.val = header
          require("alpha").redraw()
        end
      end
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
