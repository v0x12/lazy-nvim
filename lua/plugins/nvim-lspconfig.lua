local on_attach = require("util.lsp").on_attach

local config = function()
	require("neoconf").setup({})
	local cmp_nvim_lsp = require("cmp_nvim_lsp")

	local lspconfig = require("lspconfig")

	local signs = { Error = "", Warn = "!", Hint = "", Info = "" }

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- Lua
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

	-- python
	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

	-- typescript
	lspconfig.tsserver.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git", ".eslintrc.js"),
	})

	-- rust
	lspconfig.rust_analyzer.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			["rust-analyzer"] = {
				diagnostics = {
					enable = true,
				},
				cargo = {
					allFeatures = true,
				},
			},
		},
		root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),
		filetypes = { "rust" },
	})

	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")
	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local eslint_d = require("efmls-configs.linters.eslint_d")
	-- local eslint = {
	-- 	lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
	-- 	lintStdin = true,
	-- 	lintFormats = { "%f:%l:%c: %m" },
	-- 	lintIgnoreExitCode = true,
	-- 	formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
	-- 	formatStdin = true,
 --  }

	-- configure efm server
	lspconfig.efm.setup({
		filetypes = {
			"lua",
			"python",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
				python = { flake8, black },
				typescript = { eslint_d, prettier_d },
				typescriptreact = {  eslint_d, prettier_d },
			},
		},
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
		"jose-elias-alvarez/nvim-lsp-ts-utils",
		-- Format on save for rust
		{
			"rust-lang/rust.vim",
			ft = "rust",
			init = function()
				vim.g.rustfmt_autosave = 1
			end,
		},
	},
}
