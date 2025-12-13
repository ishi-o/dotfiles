return {
	{
		"HakonHarnes/img-clip.nvim",
		optional = true,
		event = "VeryLazy",
		config = function()
			require("config.enhancement.img-clip")
		end,
	},
}
