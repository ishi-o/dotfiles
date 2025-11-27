return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		lazy = false,
		config = function()
			require("config.trouble")
		end,
	},
}
