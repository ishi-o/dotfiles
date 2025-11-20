return {
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
}
