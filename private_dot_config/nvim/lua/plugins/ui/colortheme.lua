return {
	{
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			require("config.ui.colortheme")
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = false,
		lazy = true,
	},
}
