return {
	{
		"monaqa/dial.nvim",
		lazy = true,
		module = "dial.map",
		config = function()
			require("config.enhancement.dial")
		end,
	},
}
