local lspsaga = require('lspsaga')
lspsaga.setup({ -- defaults ...
	ui = {
		code_action = "󰌶",
		diagnostic = "",
	},
	lightbulb = {
		virtual_text = false,
	},
	finder = {
		scroll_down = "<C-f>",
		scroll_up = "<C-b>", -- quit can be a table
		quit = { "q", "<ESC>" },
	},
	symbol_in_winbar = {
		enable = false,
		show_file = false,
	},
})

local function op(silent, noremap)
  return {
    silent = silent,
    noremap = noremap,
  }
end

vim.keymap.set("n", "[_Lsp]r", "<cmd>Lspsaga rename ++project<cr>", op(true, true))
vim.keymap.set("n", "M", "<cmd>Lspsaga code_action<cr>", op(true, true))
vim.keymap.set("x", "M", ":<c-u>Lspsaga code_action<cr>", op(true, true))
vim.keymap.set("n", "?", "<cmd>Lspsaga hover_doc<cr>", op(true, true))
vim.keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<cr>", op(true, true))
vim.keymap.set("n", "[_Lsp]j", "<cmd>Lspsaga diagnostic_jump_next<cr>", op(true, true))
vim.keymap.set("n", "[_Lsp]k", "<cmd>Lspsaga diagnostic_jump_prev<cr>", op(true, true))
vim.keymap.set("n", "[_Lsp]f", "<cmd>Lspsaga finder<cr>", op(true, true))
vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<cr>", op(true, true))
vim.keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<cr>", op(true, true))
vim.keymap.set("n", "[_Lsp]l", "<cmd>Lspsaga show_line_diagnostics<cr>", op(true, true))
vim.keymap.set("n", "[_Lsp]c", "<cmd>Lspsaga show_cursor_diagnostics<cr>", op(true, true))
vim.keymap.set("n", "[_Lsp]b", "<cmd>Lspsaga show_buf_diagnostics<cr>", op(true, true))
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", op(true, true))
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<cr>", op(true, true))
vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<cr>", op(true, true))
vim.keymap.set("n", "[_Lsp]I", "<cmd>Lspsaga incoming_calls<cr>", op(true, true))
vim.keymap.set("n", "[_Lsp]O", "<cmd>Lspsaga outgoing_calls<cr>", op(true, true))

