return {
	{
		"folke/trouble.nvim",
		lazy = true,
		cmd = "Trouble",
		init = function()
			require("config.langservice.diagnostic").setup()
		end,
		config = function()
			require("config.langservice.diagnostic").load_trouble()
		end,
	},
}
