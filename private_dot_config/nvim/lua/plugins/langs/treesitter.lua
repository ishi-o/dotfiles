return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		version = false,
		build = ":TSUpdate",
		config = function()
			require("config.langs.treesitter")
		end,
	},
}
