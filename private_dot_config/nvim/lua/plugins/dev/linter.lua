return {
	-- nvim-lint --
	-- linter support
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = "BufReadPost",
		config = function()
			require("config.dev.linter.nvim-lint")
		end,
	},
	-- null-ls
	{
		"nvimtools/none-ls.nvim",
		enabled = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.dev.linter.null-ls")
		end,
	},
}
