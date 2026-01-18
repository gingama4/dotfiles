local wezterm = require('wezterm')

local M = {}

function M.apply(config)
  local title_cache = {}
  local ssh_host_cache = {}
  local ssh_original_cmd_cache = {}

  -- Icon
  local TAB_ICON_NEOVIM = wezterm.nerdfonts.linux_neovim
  local TAB_ICON_ZSH = wezterm.nerdfonts.dev_terminal
  local TAB_ICON_FALLBACK = wezterm.nerdfonts.md_console_network

  -- Color
  local TAB_ICON_COLOR_NEOVIM = "#57A143"
  local TAB_ICON_COLOR_ZSH = "#769ff0"
  local TAB_ICON_COLOR_FALLBACK = "#ae8b2d"
  local TAB_FOREGROUND_INACTIVE = "#a0a9cb"
  local TAB_BACKGROUND_INACTIVE = "#1d2230"
  local TAB_FOREGROUND_ACTIVE = "#313244"
  local TAB_BACKGROUND_ACTIVE = "#80EBDF"

  -- Decoration
  local SOLID_LEFT_CIRCLE = wezterm.nerdfonts.ple_left_half_circle_thick
  local SOLID_RIGHT_CIRCLE = wezterm.nerdfonts.ple_right_half_circle_thick

  local function basename(s)
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
  end

  wezterm.on("update-status", function(window, pane)
    local pane_id = pane:pane_id()

    local user_vars = pane.user_vars or {}
    title_cache[pane_id] = "-"
    local cwd_url = pane:get_current_working_dir()
    if cwd_url then
      local cwd = cwd_url.file_path
      if cwd then
        local home = os.getenv("HOME")
        if home and cwd:find("^" .. home) then
          cwd = cwd:gsub("^" .. home, "~")
        end

        local github_prefix_pattern = ".*/ghq/github.com/([^/]+)/([^/]+)"
        local user, project = cwd:match(github_prefix_pattern)
        if user and project then
          title_cache[pane_id] = project
        else
          cwd = cwd:gsub("/$", "")
          local last_dir = cwd:match("([^/]+)$")
          title_cache[pane_id] = last_dir or cwd
        end
      end
    end
  end)

  wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
    local pane = tab.active_pane
    local pane_id = pane.pane_id
    local process_name = basename(pane.foreground_process_name)

    local full_cmdline = pane.foreground_process_name or ""
    local title = pane.title or ""
    local user_vars = pane.user_vars or {}


    local background = TAB_BACKGROUND_INACTIVE
    local foreground = TAB_FOREGROUND_INACTIVE
    if tab.is_active then
      background = TAB_BACKGROUND_ACTIVE
      foreground = TAB_FOREGROUND_ACTIVE
    end
    local edge_background = TAB_BACKGROUND_INACTIVE
    local edge_foreground = background

    local cwd = "-"
    if title_cache[pane_id] then
      cwd = title_cache[pane_id]
    end

    local icon = TAB_ICON_FALLBACK
    local icon_foreground = TAB_ICON_COLOR_FALLBACK
    local cmdline = pane.foreground_process_name or ""
    local current_cwd = title_cache[pane_id] or ""

    if pane.title == "nvim" then
      icon = TAB_ICON_NEOVIM
      icon_foreground = TAB_ICON_COLOR_NEOVIM
    elseif pane.title == "zsh" then
      icon = TAB_ICON_ZSH
      icon_foreground = TAB_ICON_COLOR_ZSH
    end

    local title = " " .. wezterm.truncate_right(cwd, max_width) .. " "

    return {
      { Background = { Color = edge_background } },
      { Text = " " },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_LEFT_CIRCLE },
      { Background = { Color = background } },
      { Foreground = { Color = icon_foreground } },
      { Text = icon },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Attribute = { Intensity = "Bold" } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_RIGHT_CIRCLE },
    }
  end)
end

return M
