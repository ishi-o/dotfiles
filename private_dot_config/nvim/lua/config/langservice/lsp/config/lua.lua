local conf = require("config.langservice.lsp.conf")

vim.lsp.config("lua_ls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	settings = {
		Lua = {
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

require("lazydev").setup({
	library = {
		"lazy.nvim",
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ path = "LazyVim", words = { "LazyVim" } },
		{ path = "snacks.nvim", words = { "Snacks" } },
	},
})
