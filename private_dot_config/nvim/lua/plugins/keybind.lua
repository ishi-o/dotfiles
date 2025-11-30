return {
	-- which-key.nvim --
	-- quick keybind and guide
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("config.keybind")
		end,
	},
}
