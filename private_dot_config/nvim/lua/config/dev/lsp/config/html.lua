local conf = require("config.dev.lsp.conf")

vim.lsp.config("html", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})
