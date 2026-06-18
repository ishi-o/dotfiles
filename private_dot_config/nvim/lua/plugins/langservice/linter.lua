return {
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = "BufReadPost",
		config = function()
			require("config.langservice.linter.nvim-lint")
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		enabled = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.langservice.linter.null-ls")
		end,
	},
}
