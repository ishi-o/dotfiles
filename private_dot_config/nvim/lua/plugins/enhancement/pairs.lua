return {
	{
		"windwp/nvim-autopairs",
		config = function()
			require("config.enhancement.pairs.autopairs")
		end,
	},
	{
		"nvim-mini/mini.surround",
		enabled = false,
		config = function()
			require("config.enhancement.pairs.surround")
		end,
	},
	{
		"utilyre/sentiment.nvim",
		enabled = false,
		event = "VeryLazy",
		init = function()
			require("config.enhancement.pairs.pair-hl").setup()
		end,
		config = function()
			require("config.enhancement.pairs.pair-hl").load_sentiment()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		config = function()
			require("config.enhancement.pairs.textobjects")
		end,
	},
}
