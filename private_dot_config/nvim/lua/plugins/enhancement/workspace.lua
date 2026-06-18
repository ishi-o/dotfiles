return {
	{
		"rmagatti/auto-session",
		lazy = false,
		config = function()
			require("config.enhancement.workspace.session")
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		enabled = false,
		config = function()
			require("config.enhancement.workspace.project")
		end,
	},
}
