return {
	-- lsp core
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lsp")
		end,
	},
	---- nvim-java
	-- {
	-- 	"nvim-java/nvim-java",
	-- },
	---- jdtls KISS
	-- {
	-- 	"mfussenegger/nvim-jdtls",
	-- 	optional = true,
	-- 	ft = "java",
	-- 	dependencies = { "mfussenegger/nvim-dap" },
	-- },
	---- go
	{
		"fatih/vim-go",
		ft = "go",
	},
}
