local keymap = vim.keymap
local h_pct = 0.90
local w_pct = 0.80
local w_limit = 75
local layout_config = {
	flex = { flip_columns = 100 },
	horizontal = {
		mirror = false,
		prompt_position = "top",
		width = function(_, cols, _)
			return math.floor(cols * w_pct)
		end,
		height = function(_, _, rows)
			return math.floor(rows * h_pct)
		end,
		preview_cutoff = 10,
		preview_width = 0.5,
	},
	vertical = {
		mirror = true,
		prompt_position = "top",
		width = function(_, cols, _)
			return math.floor(cols * w_pct)
		end,
		height = function(_, _, rows)
			return math.floor(rows * h_pct)
		end,
		preview_cutoff = 10,
		preview_height = 0.5,
	},
}
local config = function()
	local telescope = require("telescope")
	local conf = require("telescope.config").values

	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
					["<C-l>"] = "preview_scrolling_down",
					["<C-h>"] = "preview_scrolling_up",
				},
			},
		},
		pickers = {
			find_files = {
				layout_strategy = "flex",
				preview_cutoff = 10,
				preview_height = 0.5,
				layout_config = layout_config,
			},
			live_grep = {
				layout_strategy = "flex",
				preview_cutoff = 10,
				preview_height = 0.5,
				layout_config = layout_config,
			},
			find_buffers = {
				layout_strategy = "flex",
				preview_cutoff = 10,
				preview_height = 0.5,
				layout_config = layout_config,
			},
		},
		-- Disabling regex in telescope live-grep so can dodge using this pattern on special characters "\{" or "\("
		-- Can use from now on like "{" or "("
		built_in = {
			live_grep = {
				vimgrep_arguments = table.insert(conf.vimgrep_arguments, "--fixed-strings"),
			},
		},
	})
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.3",
	lazy = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = config,
	keys = {
		keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>"),
		keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>"),
		keymap.set("n", "<leader>ff", ":Telescope find_files<CR>"),
		keymap.set("n", "<leader>fa", ":Telescope <CR>"),
		keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>"),
		keymap.set("n", "<leader>fb", ":Telescope buffers<CR>"),
		keymap.set("n", "<leader>fc", ":Telescope resume<CR>"),
	},
}
