return {
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = "BufReadPost",
		config = function()
			require("config.langs.linter.nvim-lint")
		end,
	},
}
