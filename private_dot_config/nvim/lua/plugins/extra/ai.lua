return {
	{
		"coder/claudecode.nvim",
		enabled = false,
		cmd = {
			"ClaudeCode",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config.extra.ai.claudecode")
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		enabled = false,
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
	{
		"yetone/avante.nvim",
		enabled = false,
		event = "VeryLazy",
		version = false,
		build = vim.fn.has("win32") ~= 0
				and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
			or "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"folke/snacks.nvim",
			"nvim-tree/nvim-web-devicons",
			"Kaiser-Yang/blink-cmp-avante",
		},
		config = function()
			require("config.extra.ai.avante")
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		enabled = false,
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "BufReadPost",
		config = function()
			require("config.extra.ai.copilot")
		end,
	},
	{
		"ravitemer/mcphub.nvim",
		enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		build = "npm install -g mcp-hub@latest",
		config = function()
			require("config.extra.ai.mcphub")
		end,
	},
}
