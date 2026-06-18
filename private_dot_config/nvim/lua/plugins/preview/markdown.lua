return {
	{
		"iamcco/markdown-preview.nvim",
		enabled = false,
		lazy = true,
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
		"OXY2DEV/markview.nvim",
		enabled = false,
		lazy = false,
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			require("markview").setup({
				preview = {
					enable = true,
					enable_hybrid_mode = true,
					linewise_hybrid_mode = false,
					hybrid_modes = { "n" },
					filetypes = { "markdown", "quarto", "rmd", "typst", "codecompanion", "Avante" },
				},
			})
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
