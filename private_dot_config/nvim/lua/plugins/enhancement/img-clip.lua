return {
	{
		"HakonHarnes/img-clip.nvim",
		enabled = false,
		event = "VeryLazy",
		config = function()
			require("config.enhancement.img-clip")
		end,
	},
}
