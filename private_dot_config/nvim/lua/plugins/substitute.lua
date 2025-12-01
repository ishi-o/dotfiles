return {
	-- substitude --
	-- inner substitude
	{
		"gbprod/substitute.nvim",
		lazy = true,
		module = "substitute",
		config = function()
			require("config.substitute.substitute")
		end,
	},
	-- spectre --
	-- ripgrep substitude
	{
		"nvim-pack/nvim-spectre",
		lazy = true,
		module = "spectre",
		config = function()
			require("config.substitute.spectre")
		end,
	},
}
