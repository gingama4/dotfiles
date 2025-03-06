---@class util.icons
local M = {}

-- stylua: ignore
M.misc = {
  dots = "󰇘",
}

-- stylua: ignore
M.ft = {
  octo = "",
}

-- stylua: ignore
M.dap = {
  Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint          = " ",
  BreakpointCondition = " ",
  BreakpointRejected  = { " ", "DiagnosticError" },
  LogPoint            = ".>",
}

-- stylua: ignore
M.diagnostics = {
  Error = " ",
  Warn  = " ",
  Hint  = " ",
  Info  = " ",
}

-- stylua: ignore
M.git = {
  added    = " ",
  modified = " ",
  removed  = " ",
}

-- stylua: ignore
M.kinds = {
  Array         = " ",
  Boolean       = "󰨙 ",
  Class         = " ",
  Codeium       = "󰘦 ",
  Color         = " ",
  Control       = " ",
  Collapsed     = " ",
  Constant      = "󰏿 ",
  Constructor   = " ",
  Copilot       = " ",
  Enum          = " ",
  EnumMember    = " ",
  Event         = " ",
  Field         = " ",
  File          = " ",
  Folder        = " ",
  Function      = "󰊕 ",
  Interface     = " ",
  Key           = " ",
  Keyword       = " ",
  Method        = "󰊕 ",
  Module        = " ",
  Namespace     = "󰦮 ",
  Null          = " ",
  Number        = "󰎠 ",
  Object        = " ",
  Operator      = " ",
  Package       = " ",
  Property      = " ",
  Reference     = " ",
  Snippet       = "󱄽 ",
  String        = " ",
  Struct        = "󰆼 ",
  Supermaven    = " ",
  TabNine       = "󰏚 ",
  Text          = " ",
  TypeParameter = " ",
  Unit          = " ",
  Value         = " ",
  Variable      = "󰀫 ",
}

return M
