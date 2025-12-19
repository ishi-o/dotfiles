return {
	-- nvim-scrollbar --
	-- scroller
	-- 滑动条
	{
		"petertriho/nvim-scrollbar",
		dependencies = {
			"lewis6991/gitsigns.nvim",
		},
		config = function()
			require("config.ui.scrollbar")
		end,
	},
}
