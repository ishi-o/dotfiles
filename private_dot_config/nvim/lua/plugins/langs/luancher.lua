return {
	{
		"stevearc/overseer.nvim",
		lazy = true,
		cmd = {
			"OverseerRun",
			"OverseerToggle",
			"OverseerTaskAction",
		},
		config = function()
			require("config.langs.launcher")
		end,
	},
}
