return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("config.langservice.complete.blink")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		enabled = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("config.langservice.complete.nvimcmp")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		enabled = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("config.langservice.complete.luasnip")
		end,
	},
	{
		"neoclide/coc.nvim",
		enabled = false,
		build = "npm install",
		config = function()
			require("config.langservice.complete.coc")
		end,
	},
}
