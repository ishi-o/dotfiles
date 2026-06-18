return {
	{
		"gbprod/substitute.nvim",
		lazy = true,
		module = "substitute",
		config = function()
			require("config.enhancement.substitute.substitute")
		end,
	},
	{
		"nvim-pack/nvim-spectre",
		enabled = false,
		lazy = true,
		module = "spectre",
		config = function()
			require("config.enhancement.substitute.spectre")
		end,
	},
	{
		"MagicDuck/grug-far.nvim",
		lazy = true,
		cmd = { "GrugFar", "GrugFarWithin" },
		config = function()
			require("config.enhancement.substitute.grug-far")
		end,
	},
}
