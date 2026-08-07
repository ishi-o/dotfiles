local conf = require("config.langs.lsp.conf")
vim.lsp.config("lua_ls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	settings = {
		Lua = {
			format = {
				enable = true,
				defaultConfig = {
					line_space_after_if_statement = "max(1)",
					line_space_after_do_statement = "max(1)",
					line_space_after_while_statement = "max(1)",
					line_space_after_repeat_statement = "max(1)",
					line_space_after_for_statement = "max(1)",
					line_space_after_local_or_assign_statement = "max(1)",
					line_space_after_function_statement = "max(1)",
					line_space_after_expression_statement = "max(1)",
					line_space_after_comment = "max(1)",
					line_space_around_block = "max(1)",
					trailing_table_separator = "smart",
				},
			},
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
				},
			},
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
					vim.fn.stdpath("config") .. "/lua",
				},
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
