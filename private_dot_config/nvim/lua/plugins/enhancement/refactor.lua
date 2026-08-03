return {
	{
		"ThePrimeagen/refactoring.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("config.enhancement.refactor")
		end,
	},
}
