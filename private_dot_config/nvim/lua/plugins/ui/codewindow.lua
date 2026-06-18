return {
	{
		"gorbit99/codewindow.nvim",
		enabled = false,
		lazy = true,
		module = "codewindow",
		config = function()
			require("config.ui.codewindow")
		end,
	},
}
