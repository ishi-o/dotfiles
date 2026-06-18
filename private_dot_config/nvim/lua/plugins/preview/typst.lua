return {
	{
		"chomosuke/typst-preview.nvim",
		enabled = false,
		lazy = true,
		ft = "typst",
		version = "1.*",
		config = function()
			require("config.preview.typst")
		end,
	},
}
