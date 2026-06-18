return {
	{
		"nvim-telescope/telescope.nvim",
		enabled = false,
		branch = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			require("config.enhancement.search.telescope")
		end,
	},
	{
		"folke/flash.nvim",
		lazy = false,
		event = "VeryLazy",
		config = function()
			require("config.enhancement.search.flash")
		end,
	},
}
