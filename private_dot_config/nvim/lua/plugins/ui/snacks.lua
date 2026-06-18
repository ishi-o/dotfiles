return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		config = function()
			require("config.ui.snacks")
		end,
	},
}
