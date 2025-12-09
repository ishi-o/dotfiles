return {
	{
		"folke/edgy.nvim",
		optional = true,
		event = "VeryLazy",
		config = function()
			require("config.edgy")
		end,
	},
}
