local ok, codecompanion = pcall(require, "codecompanion")
if ok then
	codecompanion.setup({
		display = {
			chat = {
				window = {
					position = "right",
					border = "single",
					width = math.floor(vim.o.columns * 0.35),
				},
			},
		},
		interactions = {
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
					local ok2, adapters = pcall(require, "codecompanion.adapters")
					if ok2 then
						return adapters.extend("deepseek", {
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
								max_tokens = {
									default = 2048,
								},
								temperature = {
									default = 0.3,
								},
							},
							opts = {
								language = "Chinese",
							},
						})
					end
				end,
				deepseek_inline = function()
					local ok3, adapters = pcall(require, "codecompanion.adapters")
					if ok3 then
						return adapters.extend("deepseek", {
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
								temperature = {
									default = 0,
								},
							},
							opts = {
								language = "Chinese",
							},
						})
					end
				end,
			},
		},
		prompt_library = {
			["best"] = {
				strategy = "chat",
				description = "Best response",
				opts = {
					short_name = "best",
					index = 1,
				},
				prompts = {
					{
						role = "user",
						content = [[
限制：只回答一个你觉得最好的方案；用中文回答；不要输出我没有问你的东西；最多使用四个标题

问题：
#{input}
						]],
					},
				},
			},
			["short"] = {
				strategy = "chat",
				description = "Short response",
				opts = {
					short_name = "short",
					index = 1,
				},
				prompts = {
					{
						role = "user",
						content = [[
限制：一句话回答

问题：
#{input}
						]],
					},
				},
			},
			["agent"] = {
				strategy = "chat",
				description = "Quickly agent call",
				opts = {
					short_name = "agent",
					index = 1,
				},
				prompts = {
					{
						role = "user",
						content = [[
@{agent} #{input}
						]],
					},
				},
			},
		},
		extensions = {
			-- mcphub = {
			-- 	callback = "mcphub.extensions.codecompanion",
			-- 	opts = {
			-- 		make_vars = true,
			-- 		make_slash_commands = true,
			-- 		show_result_in_chat = true,
			-- 	},
			-- },
		},
	})
end
