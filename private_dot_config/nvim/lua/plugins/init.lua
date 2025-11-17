return {
	-- lazy.nvim itself needless

	-- lsp core
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lsp")
		end,
	},

	-- complete
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			require("config.cmp")
		end,
	},

	-- colortheme
	{
		"folke/tokyonight.nvim",
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			require("config.colortheme")
		end,
	},

	-- comment
	{
		"numToStr/Comment.nvim",
		config = function()
			require("config.Comment")
		end,
	},

	-- toggleterm
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("config.toggleterm")
		end,
	},

	-- file-tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("config.neo-tree")
		end,
	},

	-- null-ls
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.none-ls")
		end,
	},

	-- nvim-dap
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			require("config.nvim-dap")
		end,
	},

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			require("config.telescope")
		end,
	},

	-- autopairs
	{
		"windwp/nvim-autopairs",
		config = function()
			require("config.autopairs")
		end,
	},

	-- git
	{
		"tpope/vim-fugitive",
		"lewis6991/gitsigns.nvim",
		config = function()
			require("config.git")
		end,
	},

	-- conform -- autoformatOnSave
	{
		"stevearc/conform.nvim",
		config = function()
			require("config.conform")
		end,
	},
}
