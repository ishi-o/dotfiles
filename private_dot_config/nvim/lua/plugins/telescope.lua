return {
	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			require("config.telescope")
		end,
	},
}
