return {
	-- mason.nvim / nvim-lspconfig --
	-- lsp manager and core
	-- lsp 管理器及其核心
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		lazy = false,
		opts = {
			servers = {
				copilot = { enabled = false },
			},
		},
		config = function()
			require("config.langservice.lsp.init")
		end,
	},
	-- vim-go --
	-- go integration
	-- go lsp 集成
	{
		"fatih/vim-go",
		lazy = true,
		ft = "go",
	},
	-- schemastore.nvim --
	-- json / yaml schema
	-- json / yaml 的模式提示
	{
		"b0o/schemastore.nvim",
		lazy = true,
		ft = { "json", "yaml" },
		init = function()
			vim.g.go_fmt_autosave = 1
			vim.g.go_highlight_types = 1
			vim.g.go_imports_mode = "goimports"
		end,
	},
	-- lazydev.nvim --
	-- lua dev lib
	-- lua 开发库支持
	{
		"folke/lazydev.nvim",
		lazy = true,
		ft = "lua",
	},
	---- nvim-java --
	---- 较重的 java lsp 集成
	-- {
	-- 	"nvim-java/nvim-java",
	-- },
	---- nvim-jdtls --
	---- 较轻的 java lsp 集成
	-- {
	-- 	"mfussenegger/nvim-jdtls",
	-- 	optional = true,
	-- 	ft = "java",
	-- 	dependencies = { "mfussenegger/nvim-dap" },
	-- },
}
