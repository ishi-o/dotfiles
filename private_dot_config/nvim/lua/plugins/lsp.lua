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
	---- java lsp | dap | cmp | linter | formatter
	-- {
	-- 	"nvim-java/nvim-java",
	-- 	opts = false,
	-- },
}
