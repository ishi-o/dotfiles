return {
	-- substitude --
	-- inner substitude
	{
		"gbprod/substitute.nvim",
		config = function()
			require("config.substitude.substitude")
		end,
	},
	-- spectre --
	-- ripgrep substitude
	{
		"nvim-pack/nvim-spectre",
		config = function()
			require("config.substitude.spectre")
		end,
	},
}
