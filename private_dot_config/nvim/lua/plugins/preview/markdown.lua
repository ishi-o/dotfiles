return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"ellisonleao/glow.nvim",
		},
		config = function()
			require("config.preview.markdown.inner-preview")
		end,
	},
	{
		"gaoDean/autolist.nvim",
		lazy = true,
		ft = {
			"markdown",
			"text",
			"tex",
			"plaintex",
			"norg",
			"gitcommit",
		},
		config = function()
			require("config.preview.markdown.autolist")
		end,
	},
}
