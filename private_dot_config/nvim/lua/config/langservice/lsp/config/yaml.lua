local conf = require("config.langservice.lsp.conf")

vim.lsp.config("yammls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),
		},
	},
})
