local function esc(x)
  return (
    x:gsub("%%", "%%%%")
      :gsub("^%^", "%%^")
      :gsub("%$$", "%%$")
      :gsub("%(", "%%(")
      :gsub("%)", "%%)")
      :gsub("%.", "%%.")
      :gsub("%[", "%%[")
      :gsub("%]", "%%]")
      :gsub("%*", "%%*")
      :gsub("%+", "%%+")
      :gsub("%-", "%%-")
      :gsub("%?", "%%?")
  )
end

local function get_cwd()
  local cwd = vim.uv.cwd()
  local git_dir = require("lualine.components.branch.git_branch").find_git_dir(cwd)
  local root = vim.fs.dirname(git_dir)
  if cwd == root then
    return ""
  end
  local d, n = string.gsub(cwd, esc(root) .. "/", "")
  if n == 0 and d == nil then
    return ""
  end
  return "󱉭 /" .. d
end

return {
  name = "lualine",
  dir = "@lualine_nvim@",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = " "
    else
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local icons = GinVim.icons

    vim.o.laststatus = vim.g.lualine_laststatus

    local opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = {
          statusline = { "snacks_dashboard" },
        },
      },
    }

    local sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = {
        { get_cwd },
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        {
          "filename",
          path = 1,
        },
      },

      lualine_x = {
        Snacks.profiler.status(),
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
        },
      },
      lualine_y = {
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      },
      lualine_z = { "hostname" },
    }

    opts.sections = sections
    opts.inactive_sections = sections

    return opts
  end,
}
