return {
	-- complete
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("config.complete")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("luasnip").config.setup({})
			require("luasnip").filetype_extend("go", { "go" })
		end,
	},
}
