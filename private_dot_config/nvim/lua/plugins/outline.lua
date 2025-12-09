return {
	{
		"stevearc/aerial.nvim",
		lazy = true,
		cmd = "AerialToggle",
		config = function()
			require("config.outline")
		end,
	},
}
