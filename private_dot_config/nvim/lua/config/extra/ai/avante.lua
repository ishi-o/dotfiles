require("avante").setup({
	mode = "legacy", -- "agentic"
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
