local set = GinVim.keymap.set

local lsp = vim.lsp
local buf = lsp.buf

-- Basic Mappings ========================================================
-- stylua: ignore start

-- Window
set({ "<C-h>", "<C-w>h", desc = "Go to Left Window" })
set({ "<C-j>", "<C-w>j", desc = "Go to Lower Window" })
set({ "<C-k>", "<C-w>k", desc = "Go to Upper Window" })
set({ "<C-l>", "<C-w>l", desc = "Go to Right Window" })

-- Terminal
set({ "<C-h>", [[<C-\><C-N><C-w>h]], mode = "t" })
set({ "<C-j>", [[<C-\><C-N><C-w>j]], mode = "t" })
set({ "<C-k>", [[<C-\><C-N><C-w>k]], mode = "t" })
set({ "<C-l>", [[<C-\><C-N><C-w>l]], mode = "t" })

-- Indent
set({ "<", "<gv", mode = "v" })
set({ ">", ">gv", mode = "v" })

-- Lsp
set({ "gd", buf.definition, desc = "Goto Definition" })
set({ "gr", buf.references, desc = "References" })
set({ "gI", buf.implementation, desc = "Goto Implementation" })
set({ "gy", buf.type_definition, desc = "Goto T[y]pe Definition" })
set({ "gD", buf.declaration, desc = "Goto Declaration" })
set({ "K", function() buf.hover({ border = "rounded", title = "Lsp Hover" }) end, desc = "hover" })
set({ "gK", function() buf.signature_help({ border = "rounded", title = "Lsp Signature Help"}) end, desc = "Signature Help" })

-- Paste
local paste_cmd = vim.fn.has('nvim-0.12') == 1 and 'iput' or 'put'
set({ "[p", '<cmd>exe "' .. paste_cmd .. '! " . v:register<cr>', desc = "Paste Above" })
set({ "]p", '<cmd>exe "' .. paste_cmd .. ' " . v:register<cr>', desc = "Paste Below" })

-- stylua: ignore end

-- Leader Mappings =======================================================
-- `<Leader>` mapper
local map_leader = function(map)
  local key = map["key"] or map[1]
  map["key"] = "<Leader>" .. key
  set(map)
end
local xmap_leader = function(map)
  map["mode"] = "x"
  map_leader(map)
end

-- stylua: ignore start

-- Buffer 'b'
map_leader({ "ba", "<cmd>b#<cr>", desc = "Alternate" })
map_leader({ "bd", "<cmd>bdelete<cr>", desc = "Delete" })

-- Lsp 'c'
map_leader({ "ca", buf.code_action, desc = "Code Action", mode = { "n", "v" } })
map_leader({ "cd", function() vim.diagnostic.open_float({ border = "rounded" }) end, desc = "Diagnostic" })
map_leader({ "cc", lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" } })
map_leader({ "cC", lsp.codelens.refresh, desc = "Refresh Codelens" })
map_leader({ "cr", buf.rename, desc = "Rename" })

-- stylua: ignore end
