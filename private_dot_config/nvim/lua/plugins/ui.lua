return {
	-- colortheme --
	{
		-- "folke/tokyonight.nvim",
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			require("config.ui.colortheme")
		end,
	},
	-- noice.nvim --
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
	-- dressing.nvim --
	-- picker (vim.ui.select)
	{
		"stevearc/dressing.nvim",
		config = function()
			require("config.ui.picker")
		end,
	},
	-- lualine.nvim --
	-- status bar (winbar / section)
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
	-- snacks.nvim --
	-- dashboard, indent, bigfile
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		-- enabled = false,
		config = function()
			require("config.ui.snacks")
		end,
	},
	-- codewindow.nvim --
	-- mini code map
	{
		"gorbit99/codewindow.nvim",
		lazy = false,
		config = function()
			require("config.ui.codewindow")
		end,
	},
	-- bufferline.nvim --
	-- bufferline / tabline
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("config.ui.tablines")
		end,
	},
}
