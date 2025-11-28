return {
	-- markdown-preview --
	-- outer preview
	{
		"iamcco/markdown-preview.nvim",
		cmd = {
			"MarkdownPreviewToggle",
			"MarkdownPreview",
			"MarkdownPreviewStop",
		},
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			require("config.preview.markdown.outer-preview")
		end,
	},
	-- render-markdown --
	-- inner preview
	{
		"MeanderingProgrammer/render-markdown.nvim",
		-- optional = true,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"ellisonleao/glow.nvim",
		},
		config = function()
			require("config.preview.markdown.inner-preview")
		end,
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
		optional = true,
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			require("markview").setup({})
		end,
	},
	-- autolist --
	{
		"gaoDean/autolist.nvim",
		ft = {
			"markdown",
			"text",
			"tex",
			"plaintex",
			"norg",
		},
		config = function()
			require("config.preview.markdown.autolist")
		end,
	},
}
