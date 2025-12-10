return {
	-- sentiment.nvim --
	-- pairs highlights
	-- 括号对高亮
	{
		"utilyre/sentiment.nvim",
		event = "VeryLazy",
		config = function()
			require("config.enhancement.pair-hl")
		end,
	},
}
