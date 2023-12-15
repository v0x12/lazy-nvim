local keymap = vim.keymap

local M = {}

--enable keybinds only for when lsp server available
M.on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts)
	keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<CR>", opts)
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition <CR>", opts)
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation<CR>", opts)
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
	keymap.set("n", "<leader>pd", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	keymap.set("n", "<leader>nd", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	keymap.set("n", "<leader>lo", "<cmd>LSoutlineToggle<CR>", opts)

	if client.name == "pyright" then
		keymap.set("n", "<Leader>oi", "<cmd>PyrightOrganizeImports<CR>", opts)
	end
end

return M
