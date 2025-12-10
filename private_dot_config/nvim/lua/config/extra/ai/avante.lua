require("avante").setup({
	provider = "deepseek",
	providers = {
		deepseek = {
			__inherited_from = "openai",

			model = "deepseek-chat",
			api_key = os.getenv("AVANTE_DEEPSEEK_API_KEY"),

			timeout = 25000,
			endpoint = "https://api.deepseek.com/v1/chat/completions",
			extra_request_body = {
				max_tokens = 8192,
				temperature = 0.4,
			},
		},
	},
	behaviour = {
		enable_inline_suggestions = false,
	},
})
