return {
	-- codecompanion.nvim --
	-- AI support
	{
		"olimorris/codecompanion.nvim",
		version = "v17.33.0",
		optional = false,
		lazy = false,
		cmd = {
			"CodeCompanion",
			"CodeCompanionActions",
			"CodeCompanionChat",
			"CodeCompanionCmd",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("config.extra.ai.codecompanion")
		end,
	},
	-- avante.nvim --
	-- AI support
	{
		"yetone/avante.nvim",
		optional = true,
		event = "VeryLazy",
		build = vim.fn.has("win32") ~= 0
				and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
			or "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
			"stevearc/dressing.nvim",
			"folke/snacks.nvim",
			"nvim-tree/nvim-web-devicons",
			"Kaiser-Yang/blink-cmp-avante",
		},
		config = function()
			require("config.extra.ai.avante")
		end,
	},
	-- copilot.lua --
	-- AI support
	{
		"zbirenbaum/copilot.lua",
		optional = true,
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "BufReadPost",
		config = function()
			require("config.extra.ai.copilot")
		end,
	},
}
