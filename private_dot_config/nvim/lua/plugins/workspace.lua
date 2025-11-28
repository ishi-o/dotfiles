return {
	-- auto-session --
	-- session manager
	{
		"rmagatti/auto-session",
		lazy = false,
		config = function()
			require("config.workspace.session")
		end,
	},
	-- project.nvim --
	-- project manager
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("config.workspace.project")
		end,
	},
}
