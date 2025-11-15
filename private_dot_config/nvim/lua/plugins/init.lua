return {
	-- lazy.nvim itself needless

	-- lsp core
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	config = function()
	-- 		require("config.lsp").setup()
	-- 	end,
	-- },
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

	-- dir-tree
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

	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.none-ls")
		end,
	},
}
