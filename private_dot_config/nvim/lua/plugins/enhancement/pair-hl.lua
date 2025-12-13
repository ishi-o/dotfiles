return {
	-- sentiment.nvim --
	-- pairs highlights
	-- 括号对高亮
	{
		"utilyre/sentiment.nvim",
		event = "VeryLazy",
		init = function()
			require("config.enhancement.pair-hl").setup()
		end,
		config = function()
			require("config.enhancement.pair-hl").load_sentiment()
		end,
	},
}
