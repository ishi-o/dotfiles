return {
	-- auto-session --
	-- session manager
	-- 会话管理器
	{
		"rmagatti/auto-session",
		lazy = false,
		config = function()
			require("config.enhancement.workspace.session")
		end,
	},
	-- project.nvim --
	-- project manager
	-- 项目管理器
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("config.enhancement.workspace.project")
		end,
	},
}
