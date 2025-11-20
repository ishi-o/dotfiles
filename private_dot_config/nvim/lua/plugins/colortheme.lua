return {
	-- colortheme
	{
		"folke/tokyonight.nvim",
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			require("config.colortheme")
		end,
	},
}
