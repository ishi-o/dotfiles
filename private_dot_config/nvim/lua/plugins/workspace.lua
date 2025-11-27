return {
	{
		"rmagatti/auto-session",
		lazy = false,
		config = function()
			require("config.workspace.session")
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("config.workspace.project")
		end,
	},
}
