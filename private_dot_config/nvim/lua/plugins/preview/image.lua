return {
	-- image.nvim --
	-- image support
	{
		"3rd/image.nvim",
		optional = true,
		config = function()
			require("config.preview.image")
		end,
	},
}
