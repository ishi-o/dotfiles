return {
	-- markdown-preview.nvim --
	-- outer preview
	-- 外部预览 (浏览器)
	{
		"iamcco/markdown-preview.nvim",
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
	-- render-markdown.nvim --
	-- inner preview
	-- 内部即时预览
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
	-- markview.nvim --
	-- inner preview
	-- 内部即时预览
	{
		"OXY2DEV/markview.nvim",
		optional = true,
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			require("markview").setup({})
		end,
	},
	-- autolist.nvim --
	-- autolist for markdown
	-- 自动处理 markdown 的列表元素
	{
		"gaoDean/autolist.nvim",
		optional = false,
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
