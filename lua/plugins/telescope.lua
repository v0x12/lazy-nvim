local keymap = vim.keymap

-- Width and height config for find_files, live_grep, and buffers
local layout_config = {
	width = function(_, max_columns)
		local max_width = 120
		local percentage = 0.5
		return math.min(math.floor(percentage * max_columns), max_width)
	end,
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
			-- Smart display for long folder names
			path_display = { "truncate" },
		},
		pickers = {
			find_files = {
				theme = "dropdown",
				hidden = true,
				layout_config = layout_config,
			},
			live_grep = {
				theme = "dropdown",
				layout_config = layout_config,
			},
			find_buffers = {
				theme = "dropdown",
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
	},
}
