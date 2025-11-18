-- require("avante").setup({})

require("codecompanion").setup({
	strategies = {
		chat = {
			adapter = "deepseek",
		},
	},
	adapters = {
		http = {
			deepseek = function()
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
				})
			end,
		},
	},
	opts = {
		language = "Chinese",
		log_level = "DEBUG",
		temperature = 0.4,
	},
})
