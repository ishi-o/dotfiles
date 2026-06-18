return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		lazy = false,
		opts = {
			servers = {
				copilot = { enabled = false },
			},
		},
		config = function()
			require("config.langservice.lsp")
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
	},
	{
		"nvim-java/nvim-java",
		optional = false,
		lazy = true,
		ft = { "java", "jproperties", "yaml", "yml" },
		config = function()
			require("config.langservice.lsp.extra.java")
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		enabled = false,
		ft = { "java", "jproperties", "yaml", "yml" },
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("config.langservice.lsp.extra.jdtls")
		end,
	},
	{
		"scalameta/nvim-metals",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		ft = { "scala", "sbt" },
		config = function()
			require("config.langservice.lsp.extra.scala")
		end,
	},
	{
		"qvalentin/helm-ls.nvim",
		lazy = true,
		ft = "helm",
		config = function()
			require("config.langservice.lsp.extra.helm")
		end,
	},
}
