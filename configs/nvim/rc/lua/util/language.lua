---@class util.language
local M = {}

---@alias FormatterConfig { formatters_by_ft: table, formatters: table }
---@alias LanguageConfig { servers: table, formatters: FormatterConfig }

---@return LanguageConfig
function M.load()
  local configs = {
    servers = {},
    formatters = {
      formatters_by_ft = {},
      formatters = {},
    },
  }

  local files = {}
  local lazy = require("lazy.core.util")
  lazy.lsmod("plugins.coding.languages", function(file)
    files[#files + 1] = file
  end)
  table.sort(files)

  for _, file in ipairs(files) do
    local config = require(file)
    if type(config) ~= "table" then
      error("Invalid server configuration in " .. file)
    end
    configs = vim.tbl_deep_extend("force", configs, config)
  end

  return configs
end

return M
