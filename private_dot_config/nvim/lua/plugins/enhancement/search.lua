return {
	{
		"folke/flash.nvim",
		lazy = false,
		event = "VeryLazy",
		config = function()
			require("config.enhancement.search.flash")
		end,
	},
}
