local conf = require("config.langs.lsp.conf")

vim.lsp.config("yamlls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	settings = {
		yaml = {
			-- schemaStore = {
			-- 	enable = true,
			-- 	url = "https://www.schemastore.org/api/json/catalog.json",
			-- },
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),
			completion = true,
			validate = true,
		},
	},
})
