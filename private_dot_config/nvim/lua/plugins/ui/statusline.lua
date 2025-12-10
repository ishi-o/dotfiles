return {
	-- lualine.nvim --
	-- status bar (winbar / section)
	-- 状态栏 (窗口栏 / 底部栏)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"SmiteshP/nvim-navic",
			"lewis6991/gitsigns.nvim",
		},
		config = function()
			require("config.ui.statusbar")
		end,
	},
}
