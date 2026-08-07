return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
		},
		lazy = false,
		opts = {
			servers = {
				copilot = { enabled = false },
			},
		},
		config = function()
			require("config.langs.lsp.init")
		end,
	},
	{
		"fatih/vim-go",
		optional = true,
		lazy = true,
		ft = "go",
		init = function()
			vim.g.go_fmt_autosave = 1
			vim.g.go_highlight_types = 1
			vim.g.go_imports_mode = "goimports"
		end,
	},
	{
		"b0o/schemastore.nvim",
		lazy = true,
		ft = { "json", "yaml" },
	},
	{
		"folke/lazydev.nvim",
		lazy = true,
		ft = "lua",
		config = function()
			require("config.langs.lsp.extra.lazydev")
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		lazy = true,
		ft = { "java" },
	},
	{
		"qvalentin/helm-ls.nvim",
		lazy = true,
		ft = "helm",
		config = function()
			require("config.langs.lsp.extra.helm")
		end,
	},
}
