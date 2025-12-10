local conf = require("config.langservice.lsp.conf")

vim.lsp.config("gopls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
})
