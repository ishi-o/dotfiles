local func = require("vim.func")
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
		optional = true,
		lazy = true,
		module = "spectre",
		config = function()
			require("config.substitute.spectre")
		end,
	},
	-- grup-far --
	-- ripgrep substitute
	{
		"MagicDuck/grug-far.nvim",
		lazy = true,
		opts = { headerMaxWidth = 80 },
		cmd = { "GrugFar", "GrugFarWithin" },
		config = function()
			require("config.substitute.grug-far")
		end,
	},
}
