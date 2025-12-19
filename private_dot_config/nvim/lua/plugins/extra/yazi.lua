return {
	"mikavilpas/yazi.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	init = function()
		require("config.extra.yazi").init()
	end,
	config = function()
		require("config.extra.yazi").setup()
	end,
}
