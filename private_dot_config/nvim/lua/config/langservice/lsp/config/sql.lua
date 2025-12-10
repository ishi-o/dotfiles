local conf = require("config.langservice.lsp.conf")

vim.lsp.config("sqlls", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})
