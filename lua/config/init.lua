local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('config.globals')
require('config.options')
require('config.keymaps')

local opts = {
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { 'carbonfox' }
	},
	rtp = {
		disabled_plugins = {
			"gzip",
			"matchit",
			"matchparen",
      "netrw",
			"netrwPlugin",
			"tarPlugin",
			"tohtml",
			"tutor",
			"zipPlugin",
		},
	},
	change_detection = {
		notify = true,
	},
}

require("lazy").setup('plugins', opts)

