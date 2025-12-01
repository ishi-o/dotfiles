return {
	-- image.nvim --
	-- image support
	{
		"3rd/image.nvim",
		lazy = true,
		ft = "image",
		config = function()
			require("config.preview.image")
		end,
	},
}
