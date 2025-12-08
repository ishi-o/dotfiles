return {
	-- mason.nvim --
	-- lsp manager and core
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			require("config.dev.lsp")
		end,
	},
	---- nvim-java --
	-- {
	-- 	"nvim-java/nvim-java",
	-- },
	---- nvim-jdtls (KISS) --
	-- {
	-- 	"mfussenegger/nvim-jdtls",
	-- 	optional = true,
	-- 	ft = "java",
	-- 	dependencies = { "mfussenegger/nvim-dap" },
	-- },
	-- vim-go --
	-- go integration
	{
		"fatih/vim-go",
		lazy = true,
		ft = "go",
	},
	-- json
	{
		"b0o/schemastore.nvim",
		lazy = true,
		ft = { "json", "yaml" },
	},
}
