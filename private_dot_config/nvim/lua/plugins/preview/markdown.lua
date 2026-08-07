return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		lazy = true,
		event = { "BufReadPost *.md", "BufNewFile *.md" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
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
