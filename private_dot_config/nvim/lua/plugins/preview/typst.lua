return {
	{
		"chomosuke/typst-preview.nvim",
		lazy = true, -- or ft = 'typst'
		ft = "typst",
		version = "1.*",
		config = function()
			require("config.preview.typst")
		end,
	},
}
