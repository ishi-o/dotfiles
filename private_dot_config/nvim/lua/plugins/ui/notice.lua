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

	-- fidget.nvim --
	-- lsp load notice in the bottom right corner
	{
		"j-hui/fidget.nvim",
		config = function()
			require("config.ui.notice.fidget")
		end,
	},
}
