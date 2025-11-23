return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"j-hui/fidget.nvim",
		},
		config = function()
			require("config.notice")
		end,
	},
}
