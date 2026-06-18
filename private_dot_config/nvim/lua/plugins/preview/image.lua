return {
	{
		"3rd/image.nvim",
		enabled = false,
		lazy = true,
		ft = "image",
		config = function()
			require("config.preview.image")
		end,
	},
}
