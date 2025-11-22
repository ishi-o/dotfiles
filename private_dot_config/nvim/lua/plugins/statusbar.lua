return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"SmiteshP/nvim-navic",
			"lewis6991/gitsigns.nvim",
		},
		config = function()
			require("config.statusbar")
		end,
	},
}
