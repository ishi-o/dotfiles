require("avante").setup({
	-- mode = "legacy",
	mode = "agentic",
	provider = "deepseek",
	providers = {
		deepseek = {
			__inherited_from = "openai",
			disable_tools = true,
			model = "deepseek-chat",
			api_key = os.getenv("DEEPSEEK_API_KEY"),
			timeout = 10000,
			endpoint = "https://api.deepseek.com",
			extra_request_body = {
				max_tokens = 4196,
				temperature = 0.2,
			},
		},
		chatgpt41 = {
			__inherited_from = "openai",
			model = "gpt-4.1",
			api_key = os.getenv("AVANTE_OPENAI_API_KEY"),
			timeout = 10000,
			endpoint = "https://api.openai.com/v1",
			extra_request_body = {
				max_tokens = 20480,
				temperature = 0.2,
			},
		},
	},
	behaviour = {
		enable_inline_suggestions = true,
		auto_set_keymaps = false,
		auto_approve_tool_permissions = false,
		auto_add_current_file = false,
		-- auto_suggestions = true,
	},
	selection = {
		hint_display = "none",
	},
	input = {
		provider = "snacks",
		provider_opts = {
			title = "Avante Input",
			icon = " ",
		},
	},
})
