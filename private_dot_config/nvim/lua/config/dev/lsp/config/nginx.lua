local conf = require("config.dev.lsp.conf")

vim.lsp.config("nginx_language_server", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})
