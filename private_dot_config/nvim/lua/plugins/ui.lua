return {
	-- colortheme
	{
		"folke/tokyonight.nvim",
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			require("config.ui.colortheme")
		end,
	},
	-- image support
	{
		"3rd/image.nvim",
		config = function()
			require("config.ui.image")
		end,
	},
	-- notice
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"j-hui/fidget.nvim",
		},
		config = function()
			require("config.ui.notice")
		end,
	},
	-- picker
	{
		"stevearc/dressing.nvim",
		config = function()
			require("config.ui.picker")
		end,
	},
	-- status bar
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"SmiteshP/nvim-navic",
			"lewis6991/gitsigns.nvim",
		},
		config = function()
			require("config.ui.statusbar")
		end,
	},
	-- markdown preview
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
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"ellisonleao/glow.nvim",
		},
		config = function()
			require("config.ui.markdown-preview")
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
	-- snacks (dashboard, indent, bigfile)
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		-- enabled = false,
		config = function()
			require("config.ui.snacks")
		end,
	},
}
