return {
	{
		-- "folke/noice.nvim",
		"j-hui/fidget.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("config.notice")
		end,
	},
}
