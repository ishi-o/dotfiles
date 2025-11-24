local conf = require("config.lsp.conf")

vim.lsp.config("bashls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})
