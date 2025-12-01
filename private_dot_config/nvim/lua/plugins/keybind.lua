return {
	-- which-key.nvim --
	-- quick keybind and guide
	{
		"folke/which-key.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("config.keybind")
		end,
	},
}
