return {
	-- noice.nvim --
	-- notice
	-- 消息系统 ui 优化
	{
		"folke/noice.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"j-hui/fidget.nvim",
		},
		config = function()
			require("config.ui.notice")
		end,
	},
}
