return {
	-- nvim-lint --
	-- linter support
	-- 静态检查支持
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = "BufReadPost",
		config = function()
			require("config.langservice.linter.nvim-lint")
		end,
	},
	-- null-ls.nvim --
	-- linter support
	-- 静态检查支持
	{
		"nvimtools/none-ls.nvim",
		enabled = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.langservice.linter.null-ls")
		end,
	},
}
