local conf = require("config.dev.lsp.conf")

vim.lsp.config("lua_ls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
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
