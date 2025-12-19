return {
	-- blink.cmp --
	-- code complete
	-- 代码补全
	{
		"saghen/blink.cmp",
		version = "1.*",
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			{
				"saghen/blink.compat",
				opts = {},
				version = not vim.g.lazyvim_blink_main and "*",
			},
			"kristijanhusak/vim-dadbod-completion",
			-- "Kaiser-Yang/blink-cmp-avante",
		},
		config = function()
			require("config.langservice.complete.blink")
		end,
	},
	-- nvim-cmp --
	-- code complete
	-- 代码补全
	{
		"hrsh7th/nvim-cmp",
		optional = true,
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
	-- LuaSnip --
	-- snippets
	-- 代码片段
	{
		"L3MON4D3/LuaSnip",
		optional = true,
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("config.langservice.complete.luasnip")
		end,
	},
	-- coc.nvim --
	-- code complete
	-- 代码补全
	{
		"neoclide/coc.nvim",
		optional = true,
		build = "npm install --frozen-lockfile",
		config = function()
			require("config.langservice.complete.coc")
		end,
	},
}
