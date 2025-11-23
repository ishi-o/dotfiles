local map = vim.keymap.set

-- require("avante").setup({})

require("codecompanion").setup({
	display = {
		chat = {
			window = {
				position = "right",
				border = "single",
				width = math.floor(vim.o.columns * 0.35),
			},
		},
	},
	strategies = {
		chat = {
			adapter = "deepseek_chat",
		},
		inline = {
			adapter = "deepseek_inline",
		},
	},
	adapters = {
		http = {
			deepseek_chat = function()
				return require("codecompanion.adapters").extend("deepseek", {
					env = {
						model = "deepseek-chat",
						url = "https://api.deepseek.com",
						api_key = function()
							return os.getenv("DEEPSEEK_API_KEY")
						end,
						chat_url = "/v1/chat/completions",
					},
					schema = {
						model = {
							default = "deepseek-chat",
						},
					},
					opts = {
						language = "Chinese",
						log_level = "DEBUG",
						temperature = 0,
					},
				})
			end,
			deepseek_inline = function()
				return require("codecompanion.adapters").extend("deepseek", {
					env = {
						model = "deepseek-chat",
						url = "https://api.deepseek.com",
						api_key = function()
							return os.getenv("DEEPSEEK_API_KEY")
						end,
						chat_url = "/v1/chat/completions",
					},
					schema = {
						model = {
							default = "deepseek-chat",
						},
					},
					opts = {
						language = "Chinese",
						log_level = "DEBUG",
						temperature = 0.4,
					},
				})
			end,
		},
	},
})

map("n", "<leader>ac", "<cmd>CodeCompanionChat<CR>", { desc = "[A]i [C]hat" })
map("n", "<leader>aa", "<cmd>CodeCompanionActions<CR>", { desc = "[A]i [A]ctions" })
