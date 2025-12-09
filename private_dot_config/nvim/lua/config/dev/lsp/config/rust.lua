local conf = require("config.dev.lsp.conf")

vim.lsp.config("rust_analyzer", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})
