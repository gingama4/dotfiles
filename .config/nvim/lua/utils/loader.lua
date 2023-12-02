local M = {}
local lazy_util = require('lazy.core.util')

function M.import(path)
  local files = {}
  lazy_util.lsmod(path, function(file)
    files[#files + 1] = file
  end)
  table.sort(files)

  return files
end

return M

