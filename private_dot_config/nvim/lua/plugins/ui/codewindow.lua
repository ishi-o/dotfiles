return {
	-- codewindow.nvim --
	-- mini code map
	-- 代码迷你地图
	{
		"gorbit99/codewindow.nvim",
		optional = true,
		lazy = true,
		module = "codewindow",
		config = function()
			require("config.ui.codewindow")
		end,
	},
}
