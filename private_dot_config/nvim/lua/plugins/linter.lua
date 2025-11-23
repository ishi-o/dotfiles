return {
	-- nvim-lint
	{
		"mfussenegger/nvim-lint",
		event = "BufReadPost",
		config = function()
			require("config.linter.nvim-lint")
		end,
	},
	-- null-ls
	{
		"nvimtools/none-ls.nvim",
		enabled = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.linter.null-ls")
		end,
	},
}
