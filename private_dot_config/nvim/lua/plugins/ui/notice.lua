return {
	{
		"folke/noice.nvim",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				config = function()
					require("config.ui.notice.notify")
				end,
			},
		},
		config = function()
			require("config.ui.notice.noice")
		end,
	},
}
