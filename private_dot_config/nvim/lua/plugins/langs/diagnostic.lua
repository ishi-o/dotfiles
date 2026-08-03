return {
	{
		"folke/trouble.nvim",
		lazy = true,
		cmd = "Trouble",
		init = function()
			require("config.langs.diagnostic").setup()
		end,
		config = function()
			require("config.langs.diagnostic").load_trouble()
		end,
	},
}
