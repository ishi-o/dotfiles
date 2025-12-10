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
						-- log_level = "DEBUG",
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
						-- log_level = "DEBUG",
						temperature = 0,
					},
				})
			end,
		},
	},
	prompt_library = {
		["best"] = {
			strategy = "chat",
			description = "强制要求AI对任何问题只输出唯一、最优、最精炼的答案",
			opts = {
				short_name = "best",
				index = 1,
			},
			prompts = {
				{
					role = "user",
					content = [[
1. 针对所有问题，输出唯一且直接最优的解决方案。
2. 禁止使用任何不确定性或引导性词语，包括但不限于：“可能”、“可以”、“建议”、“通常”、“有一种方法是”、“例如”、“接下来”。
3. 如果问题复杂，直接基于最直接、最有效的公认最佳实践路径给出方案，不讨论其他可能性。
4. 如果问题无法解决，直接输出“无法解决”，不解释原因。
5. 生成的代码不需要注释

问题：
#{input}]],
				},
			},
		},
	},
})
