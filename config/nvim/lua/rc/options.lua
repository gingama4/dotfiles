local options = {
  encoding = "utf-8",
  fileencodings = "utf-8,euc-jp,iso-2022-jp,sjis",
  fileformats = "unix,dos,mac",
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  number = true,
  splitbelow = true,
  splitright = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

