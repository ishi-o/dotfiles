return {
	-- colortheme --
	-- 颜色主题
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
		optional = true,
		lazy = true,
	},
}
