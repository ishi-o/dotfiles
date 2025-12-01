return {
	-- blink.cmp --
	-- code complete
	{
		"saghen/blink.cmp",
		lazy = false,
		version = "1.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			{
				"saghen/blink.compat",
				opts = {},
				version = not vim.g.lazyvim_blink_main and "*",
			},
		},
		config = function()
			require("config.dev.complete.blink")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		optional = true,
		enabled = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("config.dev.complete.nvimcmp")
		end,
	},
	-- LuaSnip --
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		optional = true,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("config.dev.complete.luasnip")
		end,
	},
	{
		"neoclide/coc.nvim",
		optional = true,
		build = "npm install --frozen-lockfile",
		config = function()
			require("config.dev.complete.coc")
		end,
	},
}
