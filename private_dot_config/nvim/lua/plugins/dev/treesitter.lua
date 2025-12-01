return {
	-- nvim-treesitter --
	-- syntax highlight
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		config = function()
			require("config.dev.treesitter")
		end,
	},
}
