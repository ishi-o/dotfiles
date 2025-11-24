local conf = require("config.lsp.conf")

vim.lsp.config("marksman", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})
