return {
	-- toggleterm.nvim --
	-- inner terminal integration
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("config.dev.toggleterm")
		end,
	},
}
