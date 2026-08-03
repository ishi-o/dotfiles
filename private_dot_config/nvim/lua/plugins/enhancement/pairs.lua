return {
	{
		"windwp/nvim-autopairs",
		config = function()
			require("config.enhancement.pairs.autopairs")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		config = function()
			require("config.enhancement.pairs.textobjects")
		end,
	},
}
