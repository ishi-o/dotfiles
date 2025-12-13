return {
	-- colortheme --
	-- 颜色主题
	{
		-- "folke/tokyonight.nvim",
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			require("config.ui.colortheme")
		end,
	},
}
