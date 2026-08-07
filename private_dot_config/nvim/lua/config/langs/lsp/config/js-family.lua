local conf = require("config.langs.lsp.conf")

vim.lsp.config("ts_ls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})

vim.lsp.config("jsonls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})
