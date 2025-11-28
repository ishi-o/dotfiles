return {
	-- telescope.nvim --
	-- file search
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			require("config.search.telescope")
		end,
	},
	-- flash.nvim --
	-- inner search
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		config = function()
			require("config.search.flash")
		end,
	},
}
