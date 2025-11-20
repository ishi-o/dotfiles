return {
	-- lazy.nvim itself needless

	-- lsp core
	{
		"williamboman/mason.nvim",
		-- "williamboman/mason-lspconfig.nvim",
		-- "neovim/nvim-lspconfig",
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
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- conform - autoformatOnSave
	{
		"stevearc/conform.nvim",
		config = function()
			require("config.conform")
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
			require("config.markdown-preview")
		end,
	},

	-- AI
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("config.ai")
		end,
	},
	-- {
	-- 	"yetone/avante.nvim",
	-- 	build = vim.fn.has("win32") ~= 0
	-- 			and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
	-- 		or "make",
	-- 	event = "VeryLazy",
	-- 	version = false,
	-- 	lazy = false,
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-mini/mini.pick", -- for file_selector provider mini.pick
	-- 		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
	-- 		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
	-- 		"ibhagwan/fzf-lua", -- for file_selector provider fzf
	-- 		"stevearc/dressing.nvim", -- for input provider dressing
	-- 		"folke/snacks.nvim", -- for input provider snacks
	-- 		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	-- 		"zbirenbaum/copilot.lua", -- for providers='copilot'
	-- 		{
	-- 			"HakonHarnes/img-clip.nvim",
	-- 			event = "VeryLazy",
	-- 			opts = {
	-- 				default = {
	-- 					embed_image_as_base64 = false,
	-- 					prompt_for_file_name = false,
	-- 					drag_and_drop = {
	-- 						insert_mode = true,
	-- 					},
	-- 					-- required for Windows users
	-- 					use_absolute_path = true,
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	opts = {
	-- 		provider = "deepseek",
	-- 		providers = {
	-- 			deepseek = {
	-- 				__inherited_from = "openai",
	--
	-- 				model = "deepseek-chat",
	-- 				api_key = os.getenv("AVANTE_DEEPSEEK_API_KEY"),
	--
	-- 				timeout = 25000,
	-- 				endpoint = "https://api.deepseek.com/v1/chat/completions",
	-- 				extra_request_body = {
	-- 					max_tokens = 8192,
	-- 					temperature = 0.4,
	-- 				},
	-- 			},
	-- 		},
	-- 		behaviour = {
	-- 			enable_inline_suggestions = false,
	-- 		},
	-- 	},
	-- 	-- config = function()
	-- 	-- 	require("config.ai")
	-- 	-- 	require("avante").setup({})
	-- 	-- end,
	-- },

	-- image support
	{
		"3rd/image.nvim",
		config = function()
			require("config.image")
		end,
	},

	-- ssh filesystem
	{
		"nosduco/remote-sshfs.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config.sshfs")
		end,
	},
}
