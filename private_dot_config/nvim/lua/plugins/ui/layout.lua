return {
	{
		"folke/edgy.nvim",
		enabled = false,
		event = "VeryLazy",
		config = function()
			require("config.ui.layout")
		end,
	},
}
