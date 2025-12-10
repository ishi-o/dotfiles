return {
	-- edgy.nvim --
	-- layout
	-- 布局支持
	{
		"folke/edgy.nvim",
		optional = true,
		event = "VeryLazy",
		config = function()
			require("config.ui.layout")
		end,
	},
}
